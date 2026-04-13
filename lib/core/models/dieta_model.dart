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
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Infusión a elección (Café/Té/Mate) sin azúcar + Huevos revueltos integrados con avena y trozos de manzana fresca', porciones: '2 huevos enteros, 40g de avena en copos, 1 manzana chica'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Infusión o agua + Puñado de frutos secos con trozos de fruta cítrica (naranja/mandarina)', porciones: '15g de nueces o almendras crudas, 1 mandarina o 1 naranja chica'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Pechuga de pollo a la plancha condimentada + Arroz integral hervido + Brócoli salteado al vapor', porciones: '150g pechuga de pollo, 50g arroz integral (peso crudo), 200g brócoli'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Infusión + Yogur natural o descremado mezclado con una cucharada de almendras o nueces picadas', porciones: '1 pote (200g) yogur descremado, 15g almendras'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Ensalada de hojas verdes y tomate + Atún desmenuzado aderezado con aceite de oliva crudo', porciones: '1 lata atún al natural, lechuga o rúcula libre, 1 tomate, 1 cdita aceite oliva'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'std_1', categoria: 'Proteínas', nombre: 'Pechuga de pollo', cantidadMensual: '5 kg'),
      ProductoCompra(id: 'std_2', categoria: 'Proteínas', nombre: 'Cartones de Huevo', cantidadMensual: '4 cartones (30u)'),
      ProductoCompra(id: 'std_3', categoria: 'Proteínas', nombre: 'Atún al natural', cantidadMensual: '8 latas'),
      ProductoCompra(id: 'std_4', categoria: 'Carbohidratos', nombre: 'Arroz Integral y Avena Tradicional', cantidadMensual: '2 kg arroz, 1.5 kg avena'),
      ProductoCompra(id: 'std_5', categoria: 'Grasas', nombre: 'Almendras / Nueces', cantidadMensual: '700 g'),
      ProductoCompra(id: 'std_6', categoria: 'Grasas', nombre: 'Aceite de Oliva extra virgen', cantidadMensual: '1 botella (500ml)'),
      ProductoCompra(id: 'std_7', categoria: 'Verdulería', nombre: 'Brócoli, Manzanas, Naranjas, Hojas Verdes', cantidadMensual: 'Libre demanda'),
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
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Infusión sin azúcar (Café/Té) + Pancakes proteicos preparados con claras de huevo y harina de avena', porciones: '4 claras de huevo, 40g de avena licuada'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Yogur descremado o proteico firme batido con frutas antioxidantes', porciones: '150g yogur descremado firme, media taza de arándanos o fresas'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Filete de pescado blanco horneado + Base de lentejas sazonadas y mix de vegetales fibrosos al vapor', porciones: '150g filete de merluza/tilapia magra, 60g lentejas secas cocidas, zapallo y zanahoria libre'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Infusión a elección + Bowl de yogur tipo Skyr o yogur griego espeso con hilos de miel y mix de semillas', porciones: '1 unidad de yogur proteico, 1 cdita de miel light, 1 cdita rasante lino o chía molida'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Tacos ligeros de pescado marino desmenuzado enrollados en fajitas integrales untadas con puré de aguacate y limón', porciones: '1 lata atún oscuro/salmón, 1/4 palta pequeña, 2 fajitas o tortillas integrales finas'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'pesc_1', categoria: 'Proteínas', nombre: 'Filete de Merluza/Tilapia magro', cantidadMensual: '4 kg'),
      ProductoCompra(id: 'pesc_2', categoria: 'Proteínas', nombre: 'Lentejas secas marrones', cantidadMensual: '2 kg'),
      ProductoCompra(id: 'pesc_3', categoria: 'Proteínas', nombre: 'Yogur Proteico / Skyr / Descremado', cantidadMensual: '20 potes pequeños'),
      ProductoCompra(id: 'pesc_4', categoria: 'Grasas', nombre: 'Paltas frescas (Aguacate)', cantidadMensual: '10 unidades'),
      ProductoCompra(id: 'pesc_5', categoria: 'Carbohidratos', nombre: 'Fajitas integrales (Rapiditas u otras)', cantidadMensual: '4 paquetes'),
      ProductoCompra(id: 'pesc_6', categoria: 'Vitaminas', nombre: 'Arándanos frescos o congelados / Frutos Rojos', cantidadMensual: '1 kg congelado'),
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
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Infusión negra o té de hierbas + Batido súper saciante de proteína mezclado con bebida de almendras y rodajas de pera fresca', porciones: '1 scoop de proteína (o 4 claras cocidas batidas), 200ml de bebida extra almendras, 1 pera'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Infusión digestiva + Puñado compacto de frutos secos y cuadrito de chocolate amargo oscuro libre de leche', porciones: '20g almendras o castañas, 1 cuadrado fino (15g) de chocolate negro vegano o 70% puro cacao'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Agua libre + Medallón de solomillo de cerdo cocinado a la plancha junto a papas hervidas frías y acelga/brócoli al wok', porciones: '150g solomillo limpio de cerdo magro, 150g de papas en cubitos frías, verduras verdes salteadas al agua libre'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Infusión de café negro denso + Rebanadas de Tofu duro tipo feta caliente salteado, combinado con tostadas integrales de arroz soplado', porciones: '100g bloque de tofu firme escurrido tipo feta, 3 galletas redondas inmensas fibróticas de arroz soplado'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Aguas frutales (limón) + Salteado al wok casero rápido fuego fuerte en tiras de pechuga avícola tipo fajitas, marinadas con morrones trozados colorados y lluvia de maní crudo duro', porciones: '150g pechugas cortada tipo dedos, mix vegetales julianas coloridas al sartén sin freír, 20g lluvia polvo maní crudo sin sal'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'slac_1', categoria: 'Sustitutos Lácteos', nombre: 'Bebida de almendras (Sin azúcar)', cantidadMensual: '6 tetrabriks'),
      ProductoCompra(id: 'slac_2', categoria: 'Proteínas', nombre: 'Tofu firme formato bloque y Huevos de repuesto cartonero si el tofu falta', cantidadMensual: '2 kg tofu en agua o cartones reemplazo'),
      ProductoCompra(id: 'slac_3', categoria: 'Proteínas Carne', nombre: 'Solomillo cerdo aguja limpia y Pechugas pollería magra', cantidadMensual: '2 kg Cerdo / 2.5 kg Pollo limpios'),
      ProductoCompra(id: 'slac_4', categoria: 'Carbohidratos', nombre: 'Galletitas planas redondas de Arroz Soplado', cantidadMensual: '3 bolsas o tubos alacena seco'),
      ProductoCompra(id: 'slac_5', categoria: 'Grasas Antioxidantes', nombre: 'Maní natural pelado sin freir puro y bloque macizo cacao amargo vegano 70%+', cantidadMensual: '1 kg maní bolsa gigante, 2 barras negras de repostería amargas oscuras sin cremas secas cacao polvorienta dura negra'),
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
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Mate/Té/Café + Avena tipo mazamorra con leche y banana en rodajas.', porciones: '40g de avena, 1 banana chica (100g), 150ml de leche.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Infusión o Agua + Maní o cacahuates pelados y una fruta cítrica de estación.', porciones: '15g de maní fresco pelado sin sal, 1 naranja/mandarina chica.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Carne picada al tomate (salsa ligera) sobre base de pasta seca corta.', porciones: '150g de carne picada magra, 50g de fideos secos guiseros (crudos), tomate triturado.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Té/Mate + Huevos duros al plato y una rodaja de la fruta diaria.', porciones: '2 huevos duros, media manzana o cítrico.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Guiso ligero estofado de cuarto trasero de pollo desgrasado y base de lentejas marrones.', porciones: '150g pollo sin piel, 40g (crudo) de lentejas, base vegetal (cebolla/ajo).'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'eco_1', categoria: 'Proteínas', nombre: 'Carne picada magra y Pata-Muslo de pollo', cantidadMensual: '4 kg vaca, 5 kg pollo'),
      ProductoCompra(id: 'eco_2', categoria: 'Proteínas', nombre: 'Huevos grandes (Maples de 30)', cantidadMensual: '4 maples (120 huevos)'),
      ProductoCompra(id: 'eco_3', categoria: 'Carbohidratos', nombre: 'Lentejas secas y Fideos moñito/tirabuzón', cantidadMensual: '3 kg lentejas, 3 paquetes fideos secos'),
    ],
  ),
  DietaModel(
    id: 'def_mujer_fibra',
    titulo: 'Alta Fibras',
    calorias: 1500,
    proteinas: '35%',
    carbohidratos: '35%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Infusión verde + Pudding de chía y avena hidratados la noche anterior, con tope de frutos rojos.', porciones: '15g chía, 30g avena instantánea, 50g frutos rojos, 100ml leche entera/descremada.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Bastones crudos de zanahoria, apio o pepino sumergidos en puré de garbanzos (Hummus).', porciones: '1 bol rebalsando bastones vegetales, 2 cdas de hummus natural.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Ensalada abundante: Base tupida vegetal vivo, garbanzos cocidos y atún desmenuzado.', porciones: '60g garbanzos crudos (hervidos), 1 lata de atún al natural, hojas verdes y zanahoria libre.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Té caliente + Tostadas oscuras rústicas densas untadas con ricota magra y llovizna de girasol.', porciones: '2 rodajas pan 100% integral masivo, 40g ricota magra, 1 pizca de semillas de girasol.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Filete vacuno magro o pollo a la plancha, montado sobre una cama cocida de espinaca o acelga.', porciones: '150g carne asada limpia, 1 gran atado de espinaca hervido/salteado.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'fibra_1', categoria: 'Semillas', nombre: 'Semillas de Chía y Girasol pelado', cantidadMensual: '500g c/u en frasco'),
      ProductoCompra(id: 'fibra_2', categoria: 'Secos', nombre: 'Garbanzos y Pan Integral de Molde Oscuro', cantidadMensual: '3 kg garbanzos, 4 panes de molde grandes'),
    ],
  ),
];
