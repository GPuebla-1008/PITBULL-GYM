/**
 * PITBULL GYM — Checkout Worker
 * Cloudflare Worker que genera preferencias de pago en MercadoPago
 * para el alias "pitbullgym" y redirige al checkout oficial.
 *
 * Variables de entorno requeridas (en Cloudflare Dashboard → Workers → Variables):
 *   MP_ACCESS_TOKEN  →  tu Access Token de MercadoPago (producción)
 *
 * Deploy:
 *   npx wrangler publish
 */

const ALIAS = 'pitbullgym';
const MP_API = 'https://api.mercadopago.com';

// ── CORS headers ──────────────────────────────────────────────────────────────
const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
};

// ── Respuesta JSON helpers ────────────────────────────────────────────────────
function jsonOk(data) {
  return new Response(JSON.stringify(data), {
    headers: { 'Content-Type': 'application/json', ...CORS },
  });
}

function jsonError(msg, status = 400) {
  return new Response(JSON.stringify({ error: msg }), {
    status,
    headers: { 'Content-Type': 'application/json', ...CORS },
  });
}

// ── Crear preferencia de pago en MercadoPago ──────────────────────────────────
async function createPreference(env, body) {
  const { amount, description, payer_email, external_reference } = body;

  if (!amount || isNaN(Number(amount)) || Number(amount) <= 0) {
    return jsonError('Monto inválido');
  }

  const preference = {
    items: [
      {
        title: description || 'Cuota PITBULL GYM',
        quantity: 1,
        unit_price: Number(amount),
        currency_id: 'ARS',
      },
    ],
    payer: payer_email ? { email: payer_email } : undefined,
    payment_methods: {
      // Aceptar transferencias bancarias (CBU/alias) y todos los medios
      excluded_payment_types: [],
      installments: 1,
    },
    back_urls: {
      success: 'https://pitbull-gym-100889.web.app/?payment=success',
      failure: 'https://pitbull-gym-100889.web.app/?payment=failure',
      pending: 'https://pitbull-gym-100889.web.app/?payment=pending',
    },
    auto_return: 'approved',
    external_reference: external_reference || `pitbull-${Date.now()}`,
    // Transferencia bancaria al alias "pitbullgym"
    notification_url: 'https://pitbull-gym-checkout.workers.dev/webhook',
    additional_info: `Alias de pago: ${ALIAS}`,
    statement_descriptor: 'PITBULL GYM',
  };

  const res = await fetch(`${MP_API}/checkout/preferences`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${env.MP_ACCESS_TOKEN}`,
    },
    body: JSON.stringify(preference),
  });

  if (!res.ok) {
    const err = await res.text();
    console.error('MP error:', err);
    return jsonError(`Error MercadoPago: ${res.status}`, 502);
  }

  const data = await res.json();
  return jsonOk({
    preference_id: data.id,
    init_point: data.init_point,        // URL de checkout completa
    sandbox_init_point: data.sandbox_init_point,
    alias: ALIAS,
  });
}

// ── Webhook: recibir notificaciones de pago ───────────────────────────────────
async function handleWebhook(env, request) {
  const body = await request.json().catch(() => ({}));
  console.log('Webhook received:', JSON.stringify(body));

  // Verificar estado del pago si llega un ID
  if (body.data?.id && body.type === 'payment') {
    const res = await fetch(`${MP_API}/v1/payments/${body.data.id}`, {
      headers: { Authorization: `Bearer ${env.MP_ACCESS_TOKEN}` },
    });
    const payment = await res.json();
    console.log('Payment status:', payment.status, 'Amount:', payment.transaction_amount);
    // Aquí podés agregar lógica de actualización de la BD del gym
  }

  return new Response('OK', { status: 200 });
}

// ── Link directo al alias (fallback sin preferencia) ──────────────────────────
function redirectToAlias() {
  return Response.redirect(`https://link.mercadopago.com.ar/${ALIAS}`, 302);
}

// ── Router principal ──────────────────────────────────────────────────────────
export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const method = request.method.toUpperCase();

    // Preflight CORS
    if (method === 'OPTIONS') {
      return new Response(null, { status: 204, headers: CORS });
    }

    // POST /create-preference → genera preferencia MP
    if (method === 'POST' && url.pathname === '/create-preference') {
      const body = await request.json().catch(() => ({}));
      return createPreference(env, body);
    }

    // POST /webhook → notificaciones de MercadoPago
    if (method === 'POST' && url.pathname === '/webhook') {
      return handleWebhook(env, request);
    }

    // GET /pay?amount=XXXX → crea preferencia con monto por query param
    if (method === 'GET' && url.pathname === '/pay') {
      const amount = url.searchParams.get('amount');
      const desc   = url.searchParams.get('description') || 'Cuota PITBULL GYM';
      const email  = url.searchParams.get('email') || '';
      if (!amount) return redirectToAlias();
      return createPreference(env, { amount, description: desc, payer_email: email });
    }

    // GET / → redirect directo al alias de MercadoPago
    if (method === 'GET' && url.pathname === '/') {
      return redirectToAlias();
    }

    return jsonError('Endpoint no encontrado', 404);
  },
};
