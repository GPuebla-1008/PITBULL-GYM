class ProductoCompra {
  final String id;
  final String categoria;
  final String nombre;
  final String cantidadMensual;

  ProductoCompra({
    required this.id,
    required this.categoria,
    required this.nombre,
    required this.cantidadMensual,
  });
}

class ComidaCronograma {
  final String horario;
  final String titulo;
  final String menu;
  final String porciones;

  ComidaCronograma({
    required this.horario,
    required this.titulo,
    required this.menu,
    required this.porciones,
  });
}

class DietaModel {
  final String id;
  final String titulo;
  final int calorias;
  final String proteinas;
  final String carbohidratos;
  final String grasas;
  final List<ComidaCronograma> cronograma;
  final List<ProductoCompra> listaCompraMensual;

  DietaModel({
    required this.id,
    required this.titulo,
    required this.calorias,
    required this.proteinas,
    required this.carbohidratos,
    required this.grasas,
    required this.cronograma,
    required this.listaCompraMensual,
  });
}

// Semilla de las 5 variantes para "Definición Mujer" (~1500 kcal)
final List<DietaModel> dietasDefinicionMujer = [
  DietaModel(
    id: 'def_mujer_estandar',
    titulo: 'Dieta Estándar',
    calorias: 1500,
    proteinas: '35%',
    carbohidratos: '35%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Huevos revueltos con avena y manzana', porciones: '2 huevos enteros, 40g avena, 1 manzana chica'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Pechuga de pollo con arroz integral y brócoli', porciones: '150g pollo, 50g arroz en crudo, 200g brócoli'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Yogur descremado con almendras', porciones: '1 pote (200g) yogur, 15g almendras'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Ensalada completa con atún', porciones: '1 lata al natural, lechuga, tomate, 1 cdita aceite oliva'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'std_1', categoria: 'Proteínas', nombre: 'Pechuga de pollo', cantidadMensual: '5 kg'),
      ProductoCompra(id: 'std_2', categoria: 'Proteínas', nombre: 'Cartones de Huevo', cantidadMensual: '4 cartones (30u)'),
      ProductoCompra(id: 'std_3', categoria: 'Proteínas', nombre: 'Atún al natural', cantidadMensual: '8 latas'),
      ProductoCompra(id: 'std_4', categoria: 'Carbohidratos', nombre: 'Arroz Integral', cantidadMensual: '2 kg'),
      ProductoCompra(id: 'std_5', categoria: 'Carbohidratos', nombre: 'Avena Tradicional', cantidadMensual: '1.5 kg'),
      ProductoCompra(id: 'std_6', categoria: 'Grasas', nombre: 'Almendras', cantidadMensual: '500 g'),
      ProductoCompra(id: 'std_7', categoria: 'Grasas', nombre: 'Aceite de Oliva extra virgen', cantidadMensual: '1 botella (500ml)'),
      ProductoCompra(id: 'std_8', categoria: 'Verdulería', nombre: 'Brócoli, Manzanas, Hojas Verdes', cantidadMensual: 'Semanal'),
    ],
  ),
  DietaModel(
    id: 'def_mujer_pesc',
    titulo: 'Dieta Pescatariana',
    calorias: 1500,
    proteinas: '35%',
    carbohidratos: '35%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Pancakes de avena y claras', porciones: '4 claras, 40g avena'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Filete de pescado blanco con lentejas', porciones: '150g merluza/tilapia, 60g lentejas secas, vegetales'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Yogur proteico', porciones: '1 unidad'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Tacos de atún o salmón en lata con aguacate', porciones: '1 lata, 1/4 palta pequeña, 2 fajitas integrales'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'pesc_1', categoria: 'Proteínas', nombre: 'Filete de Merluza/Tilapia congelado', cantidadMensual: '4 kg'),
      ProductoCompra(id: 'pesc_2', categoria: 'Proteínas', nombre: 'Lentejas secas', cantidadMensual: '2 kg'),
      ProductoCompra(id: 'pesc_3', categoria: 'Proteínas', nombre: 'Yogur Proteico / Skyr', cantidadMensual: '15 unidades'),
      ProductoCompra(id: 'pesc_4', categoria: 'Grasas', nombre: 'Palta (Aguacate)', cantidadMensual: '10 unidades'),
      ProductoCompra(id: 'pesc_5', categoria: 'Carbohidratos', nombre: 'Fajitas Integrales', cantidadMensual: '4 paquetes'),
    ],
  ),
  DietaModel(
    id: 'def_mujer_sinlac',
    titulo: 'Sin Lácteos',
    calorias: 1500,
    proteinas: '35%',
    carbohidratos: '35%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Batido de proteína vegetal con leche de almendras y pera', porciones: '1 scoop prote, 200ml bebida almendras, 1 pera'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Cerdo magro con papa hervida', porciones: '150g solomillo/carre, 150g papa, vegetales verdes'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Tofu revuelto (o claras) con galletas de arroz', porciones: '100g tofu, 2 tortitas de arroz'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Pollo salteado con vegetales y maní', porciones: '150g pollo, 20g maní natural'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'slac_1', categoria: 'Proteínas / Sustitutos', nombre: 'Bebida de almendras sin azúcar', cantidadMensual: '6 litros'),
      ProductoCompra(id: 'slac_2', categoria: 'Proteínas', nombre: 'Tofu firme', cantidadMensual: '2 kg'),
      ProductoCompra(id: 'slac_3', categoria: 'Proteínas', nombre: 'Solomillo de cerdo magro', cantidadMensual: '3 kg'),
      ProductoCompra(id: 'slac_4', categoria: 'Carbohidratos', nombre: 'Tortitas de arroz inflado', cantidadMensual: '3 paquetes'),
      ProductoCompra(id: 'slac_5', categoria: 'Grasas', nombre: 'Maní natural pelado (sin sal)', cantidadMensual: '1 kg'),
    ],
  ),
  DietaModel(
    id: 'def_mujer_eco',
    titulo: 'Económica',
    calorias: 1500,
    proteinas: '35%',
    carbohidratos: '35%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Avena cocida con banana y leche', porciones: '40g avena, 1 banana, 150ml leche'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Carne picada magra con fideos integrales o arroz', porciones: '150g carne especial, 50g fideos crudos, puré de tomate'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Huevos duros y 1 fruta de estación', porciones: '2 huevos, 1 mandarina/manzana/naranja'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Guiso ligero de lentejas con pollo deshuesado', porciones: '150g pollo (cuarto trasero), 40g lentejas'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'eco_1', categoria: 'Proteínas', nombre: 'Carne picada desgrasada', cantidadMensual: '4 kg'),
      ProductoCompra(id: 'eco_2', categoria: 'Proteínas', nombre: 'Cuartos traseros de pollo (pata muslo magro)', cantidadMensual: '5 kg'),
      ProductoCompra(id: 'eco_3', categoria: 'Carbohidratos', nombre: 'Fideos Integrales', cantidadMensual: '2 paquetes'),
      ProductoCompra(id: 'eco_4', categoria: 'Carbohidratos', nombre: 'Lentejas secas', cantidadMensual: '3 kg'),
      ProductoCompra(id: 'eco_5', categoria: 'Verdulería / Frutas', nombre: 'Bananas, Naranjas, Manzanas', cantidadMensual: 'Semanal'),
    ],
  ),
  DietaModel(
    id: 'def_mujer_fibra',
    titulo: 'Alta Fibra',
    calorias: 1500,
    proteinas: '35%',
    carbohidratos: '35%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Pudding de chía, avena y mix de frutos rojos', porciones: '15g chía, 30g avena, 50g frutos rojos, leche'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Ensalada masiva de garbanzos y atún', porciones: '60g garbanzos crudos, 1 lata atún, lechuga, zanahoria rallada'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Pan integral con ricota magra y semillas', porciones: '2 rodajas pan 100% integral, 40g ricota, 1 cdita semillas girasol'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Carne magra (vaca/pollo) con espinaca salteada', porciones: '150g carne, 1 paquete grande espinaca'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'fibra_1', categoria: 'Grasas / Fibras', nombre: 'Semillas de Chía y Girasol', cantidadMensual: '500g c/u'),
      ProductoCompra(id: 'fibra_2', categoria: 'Carbohidratos', nombre: 'Garbanzos secos', cantidadMensual: '2 kg'),
      ProductoCompra(id: 'fibra_3', categoria: 'Carbohidratos', nombre: 'Pan de molde 100% integral', cantidadMensual: '4 paquetes'),
      ProductoCompra(id: 'fibra_4', categoria: 'Proteínas', nombre: 'Ricota Magra / Queso Cottage', cantidadMensual: '3 potes (500g)'),
      ProductoCompra(id: 'fibra_5', categoria: 'Vitaminas', nombre: 'Frutos rojos congelados', cantidadMensual: '1 kg'),
    ],
  ),
];
