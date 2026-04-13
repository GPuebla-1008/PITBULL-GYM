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

// Semilla de las 5 variantes para "Definición Hombre" (~2200 kcal, Macros: 30% Prot / 40% Carb / 30% Grasas)
final List<DietaModel> dietasDefinicionHombre = [
  DietaModel(
    id: 'def_hombre_estandar',
    titulo: 'Estándar Masculina',
    calorias: 2200,
    proteinas: '30%',
    carbohidratos: '40%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Café o Té negro + Huevos enteros revueltos con avena integral y manzana trozada', porciones: '3-4 huevos enteros, 80g avena instantánea, 1 manzana grande'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Infusión o agua + Puñado abundante de frutos secos mixtos y fruta cítrica', porciones: '30g nueces/almendras, 1 naranja o 2 mandarinas'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Pechuga o carne roja magra a la plancha + Arroz integral + Brócoli abundante', porciones: '200g carne/pollo magro, 80g arroz crudo, 300g brócoli verde'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Mate/Café negro + Yogur natural con semillas y cucharada sopera de nueces trituradas', porciones: '2 potes (250g) yogur descremado, 30g nueces/almendras'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Ensalada gigante verde + Atún al natural escurrido, tomates y cucharada alta de aceite de oliva', porciones: '2 latas de atún al agua, col/lechuga libre, 2 tomates, 1 cda sopera aceite oliva'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'h_std_1', categoria: 'Proteínas', nombre: 'Carne Magra y Pollo', cantidadMensual: '8 kg combinados'),
      ProductoCompra(id: 'h_std_2', categoria: 'Proteínas', nombre: 'Maples de Huevos', cantidadMensual: '5 maples (150 u)'),
      ProductoCompra(id: 'h_std_3', categoria: 'Carbohidratos', nombre: 'Arroz Integral Fino y Avena', cantidadMensual: '3 kg arroz, 2.5 kg avena'),
      ProductoCompra(id: 'h_std_4', categoria: 'Grasas', nombre: 'Frutos Secos (Nueces/Almendras)', cantidadMensual: '1 kg mixto'),
    ],
  ),
  DietaModel(
    id: 'def_hombre_pesc',
    titulo: 'Pescatariana High-Protein',
    calorias: 2200,
    proteinas: '30%',
    carbohidratos: '40%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Infusión + Maxi-Pancakes de avena fina y claras pasteurizadas', porciones: '6 claras y 1 yema o 200ml claras de cartón, 80g avena'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Yogur proteico enorme batido con arándanos o frutos rojos congelados', porciones: '250g yogur proteico, 1 taza arándanos'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Pescado blanco o Salmón + Quinoa sazonada y vegetales fibrosos', porciones: '250g pescado magro, 80g quinoa cruda, zanahorias/zapallo al vapor'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Infusión + Yogur Skyr o griego mezclado en bowl con mix de semillas molidas', porciones: '2 yogures skyr, 2 cdas rasas de semillas chía/lino'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Tacos fríos de Atún natural envueltos en lechuga capuchina o fajita ligera y palta', porciones: '2 latas atún escurrido, 1/2 palta grande, base hojas de lechuga dura'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'h_pesc_1', categoria: 'Proteínas', nombre: 'Pescado Blanco Congelado (Merluza/Tilapia/Abadejo)', cantidadMensual: '7 kg al freezer'),
      ProductoCompra(id: 'h_pesc_2', categoria: 'Proteínas', nombre: 'Claras en envase pasteurizadas', cantidadMensual: '8 litros (Cajas grandes)'),
      ProductoCompra(id: 'h_pesc_3', categoria: 'Carbohidratos', nombre: 'Quinoa en grano', cantidadMensual: '3 kg en paquete'),
      ProductoCompra(id: 'h_pesc_4', categoria: 'Grasas', nombre: 'Paltas / Aguacates Extra', cantidadMensual: '15 unidades mensuales'),
    ],
  ),
  DietaModel(
    id: 'def_hombre_sinlac',
    titulo: 'Keto-Friendly / Sin Lácteos',
    calorias: 2200,
    proteinas: '30%',
    carbohidratos: '40%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Café o Té + Batido recargado de aislado de proteína, crema de maní y bebida de almendras o vegetal', porciones: '1.5 scoop proteína Isolate o 5 claras, 300ml leche vegetal, 1 pera'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Infusión + Puñado rotundo de frutos secos crocantes y tableta profunda chocolate amargo +70%', porciones: '35g mix frutos duros, 20g chocolate vegano amargo estricto'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Lomo o solomillo de cerdo a la plancha + Papas al natural reposadas y wok vegetal verde profundo', porciones: '200g solomillo de cerdo desgrasado, 200g papas cúbicas, acelga/espinaca libre'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Café amargo denso + Tofu bloque duro salteado tipo revuelto, apoyado en colchon de galletas de arroz', porciones: '150g tofu tipo feta o bloque firme, 4 o 5 tostadas grandes integrales de arroz'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Pollo en tiras rápido crujientes estilo Wok con maní trozado crudo y vegetales colorados marinados en soja light', porciones: '200g pechuga dados, julianas de verduras, 30g polvo de maní crudo denso'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'h_slac_1', categoria: 'Lácteos Sustitutos', nombre: 'Bebida de almendras / maní sin azúcar', cantidadMensual: '10 cajas Brik grandes'),
      ProductoCompra(id: 'h_slac_2', categoria: 'Proteínas', nombre: 'Proteína Polvo Isolate o Claras de Campo', cantidadMensual: '2 tarros 900g o 10 maples'),
      ProductoCompra(id: 'h_slac_3', categoria: 'Grasas', nombre: 'Mantequilla de Maní Natural %100', cantidadMensual: '2 potes 500g sueltos alacena'),
      ProductoCompra(id: 'h_slac_4', categoria: 'Carboidratos', nombre: 'Tostadas disco grandes de arroz liso', cantidadMensual: '5 tubos / bolsas largas'),
    ],
  ),
  DietaModel(
    id: 'def_hombre_eco',
    titulo: 'Económica y Práctica',
    calorias: 2200,
    proteinas: '30%',
    carbohidratos: '40%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Mate/Té + Bol inmenso tipo mazamorra de avena caliente con rodaja de banana y lácteo', porciones: '80g avena gruesa hidratada, 1 banana mediana, 200ml lácteo o agua.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Infusión o agua + Maní crudo y cítricos fuertes.', porciones: '30g maní crudo soso o tostado, 2 naranjas o mandarinas enteras.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Guiso "Boloñesa Ligera": Aguja picada magra sudada en puré de tomate y fideos largos.', porciones: '200g carne vacuna magra desgrasada, 80g pasta en seco hervida.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Mate cebado + Huevos duros rendidores y fruta rápida de estación.', porciones: '3 huevos gigantes duros tajeados, 1 cítrico chico.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Muslos o pata de pollo hervidos desgrasados con base profunda de lentejas escurridas.', porciones: '200g carne de ave sin piel, 80g legumbres secas hidratadas al dente.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'h_eco_1', categoria: 'Proteínas Vaca/Ave', nombre: 'Carne de aguja/especial y Cajón patamuslo', cantidadMensual: '5 kg res fina, 8 kg cuartos de pollo'),
      ProductoCompra(id: 'h_eco_2', categoria: 'Huevos y Fibras', nombre: 'Maples inmensos L y Lentejas', cantidadMensual: '7 maples (210 huevos), 5 kg lentejas'),
      ProductoCompra(id: 'h_eco_3', categoria: 'Carbohidratos', nombre: 'Fideos simples y Avena granel', cantidadMensual: '5 kg pasta seca, 4 kg avena gruesa'),
    ],
  ),
  DietaModel(
    id: 'def_hombre_fibra',
    titulo: 'Alto Rendimiento y Fibras',
    calorias: 2200,
    proteinas: '30%',
    carbohidratos: '40%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Té verde + Pudding Overnight en tupper: chía sumergida, copos de avena y bayas.', porciones: '25g chía viscosa, 60g avena instantánea, 100g bayas congeladas rojas, 150ml bebida/agua.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Bastones de apio o pepino gruesos sumergidos en puré casero de garbanzo (Hummus).', porciones: '2 tazas soperas rebalsantes hortalizas, 3 cdas hondas puré neutro de garbanzo.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Bol inmenso crudo: Garbanzos gruesos pesados unidos con atún y colchón de verduras de hoja verde oscuro.', porciones: '100g garbanzos crudos (estallados rinden mas), 2 latas atún agua, hojas frondosas de col, rúcula o zanahoria.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Infusión oscura caliente + Pan integral pesado untado de ricota espesa clara y chispas de maravilla blanca.', porciones: '4 rodajas masa madre oscura, 80g ricota untable firme extra magra, lluvia llovizna de girasol pelado puro.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Plancha oscura al rojo vivo secando bife filete magro + cama gigante al ajo vaporizada.', porciones: '200g rojo vacuno puro/pollo pechuguero plano grueso asado al limón sin aceites, colchones grandes verdes atados hervidor de espinaca ajillo sal sutil colador verdes hojas blandísimos digestivas planas pesados blandos al dormir regeneradores musculares fofas sutil purite colchona asadas estomgo panzs.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'h_fib_1', categoria: 'Grasos Densos Semillas Puras', nombre: 'Chía y Girasol pelado', cantidadMensual: '1 kg chia, 1 kg maravilla pelada.'),
      ProductoCompra(id: 'h_fib_2', categoria: 'Carbohidratos Densos', nombre: 'Garbanzos gruesos y Panes Negros Molde', cantidadMensual: '4 paquetes grandes masa negra de amasar u panaderos asados duros salvados fofos moldes gruesos de la pura bolsa, 3 kg soso de rústico soso rudo ambar garbazal.'),
    ],
  ),
];
