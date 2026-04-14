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
      ProductoCompra(id: 'h_std_1', categoria: 'Proteínas (Carnes)', nombre: 'Pechugas de pollo y Carne vacuna magra (nalga, cuadril)', cantidadMensual: '8 kg pollo, 4 kg vaca'),
      ProductoCompra(id: 'h_std_2', categoria: 'Proteínas (Huevos/Lácteos)', nombre: 'Huevos grandes, Yogur natural descremado', cantidadMensual: '5 maples de 30 huevos, 20 potes yogur descremado'),
      ProductoCompra(id: 'h_std_3', categoria: 'Carbohidratos', nombre: 'Avena instantánea, Arroz integral, Manzanas y Naranjas', cantidadMensual: '3 kg avena, 3 kg arroz, 30 manzanas, 40 naranjas'),
      ProductoCompra(id: 'h_std_4', categoria: 'Vegetales/Fibras', nombre: 'Brócoli fresco, Tomates, Lechuga/Col, Atún natural', cantidadMensual: '5 atados brócoli, 3 kg tomates, lechuga libre, 15 latas atún'),
      ProductoCompra(id: 'h_std_5', categoria: 'Grasas Saludables', nombre: 'Mix de Frutos Secos (Nueces/Almendras), Aceite de Oliva Extra Virgen', cantidadMensual: '1.5 kg mix, 1 botella de 500ml oliva'),
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
      ProductoCompra(id: 'h_pesc_1', categoria: 'Proteínas (Pescado)', nombre: 'Filetes de pescado blanco (Merluza/Tilapia) y Atún al natural', cantidadMensual: '8 kg pescado congelado, 30 latas de atún'),
      ProductoCompra(id: 'h_pesc_2', categoria: 'Proteínas (Huevos/Lácteos)', nombre: 'Claras pasteurizadas en cartón, Yogur proteico / Skyr', cantidadMensual: '8 litros puras claras, 40 potes yogur proteico'),
      ProductoCompra(id: 'h_pesc_3', categoria: 'Carbohidratos', nombre: 'Avena fina, Quinoa en grano, Arándanos/Frutos Rojos', cantidadMensual: '3 kg avena, 3 kg quinoa, 2 kg atados de frutos rojos fríos'),
      ProductoCompra(id: 'h_pesc_4', categoria: 'Vegetales/Fibras', nombre: 'Zanahorias, Zapallo, Lechuga capuchina dura', cantidadMensual: '4 kg zanahorias, 4 kg zapallo/calabaza, hojas libres'),
      ProductoCompra(id: 'h_pesc_5', categoria: 'Grasas Saludables', nombre: 'Semillas de chía/lino, Paltas (Aguacate)', cantidadMensual: '500g semillas, 15 paltas'),
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
      ProductoCompra(id: 'h_slac_1', categoria: 'Proteínas', nombre: 'Cerdo Magro (Solomillo), Pechuga de pollo cortada, Proteína Isolate o Claras', cantidadMensual: '6 kg cerdo, 6 kg pollo, 2 tarros whey proteín o 10 maples'),
      ProductoCompra(id: 'h_slac_2', categoria: 'Sustitutos/Vegetal', nombre: 'Tofu firme (bloque), Bebida de almendras o maní sin azúcar', cantidadMensual: '4 kg tofu, 10 cajas de leche vegetal (litro)'),
      ProductoCompra(id: 'h_slac_3', categoria: 'Carbohidratos', nombre: 'Papas para hervir, Galletas de arroz integrales extra grandes, Peras', cantidadMensual: '6 kg papas, 6 tubos galletas arroz, 20 peras'),
      ProductoCompra(id: 'h_slac_4', categoria: 'Vegetales', nombre: 'Acelga o Espinaca fresca, Verduras para Wok (morrón, cebolla, zanahoria)', cantidadMensual: '6 atados espinaca y bolsitas libres p/wok'),
      ProductoCompra(id: 'h_slac_5', categoria: 'Grasas Saludables', nombre: 'Mantequilla de mani natural (sin azúcar), Maní crudo, Coco/Chocolate amargo 70%+', cantidadMensual: '1 kg crema mani, 1 kg maní suelto, 5 tabletas chocolate'),
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
      ProductoCompra(id: 'h_eco_1', categoria: 'Proteínas', nombre: 'Carne picada de aguja (magra), Pata y Muslo de pollo económicos', cantidadMensual: '6 kg carne molida magra, 10 kg cuartos pollos'),
      ProductoCompra(id: 'h_eco_2', categoria: 'Proteínas (Huevos)', nombre: 'Maples de cartón de Huevos grandes', cantidadMensual: '7 maples (210 huevos en total)'),
      ProductoCompra(id: 'h_eco_3', categoria: 'Carbohidratos / Almidones', nombre: 'Avena común gruesa, Fideos tipo espagueti secos, Lentejas rubias', cantidadMensual: '4 kg avena granel, 5 kg fideos, 5 kg lentejas sueltas'),
      ProductoCompra(id: 'h_eco_4', categoria: 'Frutas y Vegetales', nombre: 'Bananas medianas, Naranjas de jugo, Puré de tomate en caja', cantidadMensual: '25 bananas, 40 naranjas, 15 purés de tomate tetrabrik'),
      ProductoCompra(id: 'h_eco_5', categoria: 'Grasas y Lácteos', nombre: 'Maní pelado suelto y Leche en sachet entera o descremada', cantidadMensual: '1.5 kg maní basto, 10 sachets leche'),
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
      ProductoCompra(id: 'h_fib_1', categoria: 'Proteínas', nombre: 'Filete magro pesado (lomo/cuadril) o Pechugas, Atún al agua y Puré de Garbanzo', cantidadMensual: '7 kg carne limpia (alternar pollo/vaca), 15 latas atún'),
      ProductoCompra(id: 'h_fib_2', categoria: 'Fibras Densas', nombre: 'Garbanzos sueltos o enlatados', cantidadMensual: '5 kg garbanzos a granel'),
      ProductoCompra(id: 'h_fib_3', categoria: 'Carbohidratos', nombre: 'Avena instantánea, Pan integral 100% de molde oscuro', cantidadMensual: '4 kg avena, 6 paquetes de pan salvado espeso'),
      ProductoCompra(id: 'h_fib_4', categoria: 'Vegetales Base', nombre: 'Espinaca gigante, Rúcula, Zanahorias espesas, Apio y Pepinillos', cantidadMensual: '8 atados espinaca, 4 atados rúcula, 6 atados apio, 5 kg zanahoria'),
      ProductoCompra(id: 'h_fib_5', categoria: 'Grasas / Adiciones', nombre: 'Semillas de Chía, Semillas maravilla blanca (Girasol pelado), Ricota magra', cantidadMensual: '1 kg chía, 1 kg girasol, 4 potes grandes ricota'),
    ],
  ),
];

// Semilla de las 5 variantes para "Ganancia Muscular Mujer" (~2000 kcal, Macros: 25-30% Prot / 45-50% Carb / 20-25% Grasas)
final List<DietaModel> dietasGananciaMujer = [
  DietaModel(
    id: 'gan_mujer_estandar',
    titulo: 'Estándar Ganancia',
    calorias: 2000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Té/Café + Huevos revueltos, Avena gruesa y rodajas de batata dorada.', porciones: '2-3 huevos, 60g avena hidratada, 100g batata asada.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Infusión + Yogur natural con frutos secos y rebanada de pan lactal.', porciones: '200g yogur, 30g mix nueces/almendras, 1 rebanada pan molde.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Pechuga magra o cuadril + Arroz integral y vegetales tupidos.', porciones: '150g carne/pollo, 100g arroz pesado crudo, vegetales libres.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Mate cebado + Tostadas gruesas y mermelada sutil con queso ricota.', porciones: '3 tostadas salvado, 60g ricota, 2 cucharaditas mermelada.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Pollo desmenuzado en colchón de fideos secos asados y verduras cocidas.', porciones: '150g pollo magro, 80g pasta, espinaca/acelga hervida.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'g_std_1', categoria: 'Proteínas (Carnes)', nombre: 'Pechuga de Pollo y Cortes vacunos magros', cantidadMensual: '5 kg pollo, 3 kg carne vacuna'),
      ProductoCompra(id: 'g_std_2', categoria: 'Proteínas (Huevos/Lácteos)', nombre: 'Maples grandes de Huevos, Yogur descremado y Ricota', cantidadMensual: '4 maples grandes, 15 potes yogures, 3 potes ricota magra'),
      ProductoCompra(id: 'g_std_3', categoria: 'Carbohidratos (Energía)', nombre: 'Avena gruesa, Arroz integral, Batatas/Papas, Pan Molde oscuro, Fideos secos', cantidadMensual: '3 kg avena, 3 kg arroz, 3 kg batatas, 4 panes de molde, 2 kg fideos'),
      ProductoCompra(id: 'g_std_4', categoria: 'Vegetales/Fibras', nombre: 'Atados vegetales (espinaca/acelga), Verdura de wok/hervor libre', cantidadMensual: '8 atados oscuros, tomates/lechugas frescos libre demanda'),
      ProductoCompra(id: 'g_std_5', categoria: 'Grasas Saludables', nombre: 'Mix de Frutos Secos (Almendras/Nueces)', cantidadMensual: '1 kg mix frutos'),
    ],
  ),
  DietaModel(
    id: 'gan_mujer_pesc',
    titulo: 'Power-Veggie (Pescatariana)',
    calorias: 2000,
    proteinas: '30%',
    carbohidratos: '45%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Infusión + Pancakes a base de 1 huevo, claras pasteurizadas y avena fina.', porciones: '1 huevo + 100ml claras, 60g avena instantánea.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Licuado ligero de yogur descremado, semillas y frutos rojos.', porciones: '200g yogur, 1 taza frutos rojos, 15g chía/lino.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Medallón de Salmón o pescado azul asado + Quinoa y base de Garbanzos.', porciones: '150g pescado magro, 70g quinoa cruda, 50g garbanzos cocidos.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Skyr o yogur griego con granola gruesa sin azúcar.', porciones: '200g yogur proteico, 40g granola nuez/avena.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Fajitas integrales rellenas de Atún al natural, Lentejas rubias y verduras crocantes.', porciones: '1.5 latas atún escurrido, 2 fajitas integrales grandes, 40g lentejas cocidas.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'g_pesc_1', categoria: 'Proteínas (Pescado)', nombre: 'Filetes de pescado fino (Salmón/Atún natural/Merluza)', cantidadMensual: '6 kg Pescado congelado, 15 latas Atún al agua'),
      ProductoCompra(id: 'g_pesc_2', categoria: 'Proteínas (Huevos/Lácteos)', nombre: 'Claras en caja, Huevos y Yogur Griego/Skyr', cantidadMensual: '2 Litros Claras, 2 Maples de Huevo, 20 potes Skyr/Yogur'),
      ProductoCompra(id: 'g_pesc_3', categoria: 'Carbohidratos', nombre: 'Avena, Quinoa y Wraps Integrales', cantidadMensual: '2 kg Avena, 2 kg Quinoa fina, 6 paquetes tortillas integrales'),
      ProductoCompra(id: 'g_pesc_4', categoria: 'Carbohidratos (Legumbres)', nombre: 'Garbanzos sueltos y Lentejas pardas', cantidadMensual: '2 kg Garbanzos seco, 2 kg Lentejas secas'),
      ProductoCompra(id: 'g_pesc_5', categoria: 'Grasas Vivas', nombre: 'Frutos rojos (congelados), Granola proteica, Semillas combinadas', cantidadMensual: '2 kg frutos congelados, 1 kg Granola sin azúcar, 500g Chía/Lino'),
    ],
  ),
  DietaModel(
    id: 'gan_mujer_sinlac',
    titulo: 'Crecimiento Limpio (Sin Lácteos)',
    calorias: 2000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Batido en leche de coco/almendras, Polvo Isolate de Proteína y Tostadas sopladas.', porciones: '300ml leche vegetal, 1 scoop prote, 3 galletas arroz grandes.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Bol de frutas ácidas frescas con abundante lluvia de maní molido y almendras.', porciones: '2 cítricos (Naranja/Kiwi), 30g mix maní/almendras.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Tofu firme salteado fuerte + Ensalada verde tupida con trozos de Palta y Aceite de Oliva.', porciones: '150g Tofu tipo feta, 1 Palta mediana, Verdes libres, 1 Cda Oliva.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Té caliente + Pan negro rústico untado con Hummus ligero.', porciones: '3 rebanadas pan oscuro integral, 2-3 Cdas puré Hummus sutil.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Supremas de Ave a la plancha con papas/batatas al horno.', porciones: '150g pechuga ave gruesa, 200g patatas asadas secas, verdura cruda libre.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'g_slac_1', categoria: 'Proteínas Vivas', nombre: 'Tofu duro compactado, Suprema/Pechuga avícola', cantidadMensual: '3 kg Tofu crudo bloque, 6 kg pollo congelado'),
      ProductoCompra(id: 'g_slac_2', categoria: 'Proteínas (Sustitutos)', nombre: 'Leche (Coco/Almendra sin Azúcar) y Whey Protein Isolate/Soya', cantidadMensual: '10 Litros bebida vegana cajón, 1 Frasco Suplemento (900g)'),
      ProductoCompra(id: 'g_slac_3', categoria: 'Grasas y Vegetales', nombre: 'Paltas Frescas Aguacates, Aceites Puro Oliva prensado', cantidadMensual: '15 Paltas, 1 Botella Oliva 500ml'),
      ProductoCompra(id: 'g_slac_4', categoria: 'Carbohidratos', nombre: 'Discos Arroz Gigantes, Tubérculos (Papa/Batata), Pan Molde 100% integral', cantidadMensual: '4 tubos galletas arroz, 5 kg papas/batatas, 3 panes oscuros salvado'),
      ProductoCompra(id: 'g_slac_5', categoria: 'Misc y Snackings', nombre: 'Maní/Almendra crudo, Cítricos estacionales, Hummus casero/lata', cantidadMensual: '1.5 kg maní/almendras, Cítricos libres demanda'),
    ],
  ),
  DietaModel(
    id: 'gan_mujer_eco',
    titulo: 'Económica Voluminizadora',
    calorias: 2000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Mate/Té + Inmensa taza tipo mazamorra de Avena, Bananas y miel.', porciones: '80g gruesa avena hidratada hervidor, 2 Bananas, gota leche o agua.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Cítricos firmes o Manzanas y puñado Maní rústico crudo.', porciones: '2 frutas diarias temporada, 30g Maní baratísimo.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Pastas tirabuzones con salsa roja y picada magra de res.', porciones: '120g Fideos secos, 100g carne magra triturada, salsa tetrabrik.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Mate/Té + Huevos hervidos duros.', porciones: '3 huevos grandes duros pasados amarillentos.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Lentejas rubias base escurridas con tiras de pollo (pata-muslo) estofadas y cebollín.', porciones: '100g legumbres secas hidratadas, 150g pata-muslo magro de pollo.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'g_eco_1', categoria: 'Proteína Económica', nombre: 'Maples grandes de Huevos', cantidadMensual: '6 maples inmensos (180 huevos)'),
      ProductoCompra(id: 'g_eco_2', categoria: 'Carnes de Rendimiento', nombre: 'Carne picada de res (magra/aguja) y Cajón Pata-Muslo avícola', cantidadMensual: '4 kg Picada Vacuna magra, 8 kg Cuartos pollería'),
      ProductoCompra(id: 'g_eco_3', categoria: 'Carbohidratos Puros', nombre: 'Fideos simples italianos, Avena comercial granel, Lentejas rubias', cantidadMensual: '5 kg Fideos crudos, 4 kg Avena, 4 kg Lentejas secas'),
      ProductoCompra(id: 'g_eco_4', categoria: 'Fibras/Vitaminas', nombre: 'Pomelo/Manzanas/Bananas (cajón verdulero), Maní pelado', cantidadMensual: 'Cajones diarios estacionales libres, 1.5kg Maní cacahuate a peso'),
    ],
  ),
  DietaModel(
    id: 'gan_mujer_fibra',
    titulo: 'Alta Densidad Nutritiva (Smoothies)',
    calorias: 2000,
    proteinas: '30%',
    carbohidratos: '45%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Mega Smoothie Verde: Batido de Avena, Chía hidratada, Espinaca cruda neutra y Frutos Rojos agrios', porciones: '50g Avena, 10g Chía, 1 puñado Espinaca/Berries, 150ml líquidos lácteos'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Crackers integrales extra gruesas untadas de Mantequilla de Maní y lluvia de lino.', porciones: '4 Crackers cuadradas grandes, 2 Cdas espesas pasta maní puro.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo', menu: 'Cuadril bovino asado / o Pollo a la plancha + Quinoa tupida con espinaca.', porciones: '150g rojo cárnico filete, 80g de quinoa/arroz integral pesada en seco, verduras vapor.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Pudding frío en vaso: Yogur proteico, rodajas de banana y avena instantánea.', porciones: '1 base yogur firme, 1 Banana en rodajas, 1 puñado avena espolvoreada.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Filete magro oscuro y colchón de Tubérculos aplastados al ajo (Papas/Batatas).', porciones: '150g cárnico oscuro o atún natural libre aceites, 150g tubérculos batatas o papas pesadas puré.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'g_fib_1', categoria: 'Bebibles/Licuados', nombre: 'Leches fluidas y Frutos Rojos/Arándanos', cantidadMensual: 'Frutos bosque congelados 1.5kg, Leches en caja 4 litros'),
      ProductoCompra(id: 'g_fib_2', categoria: 'Grasas untables', nombre: 'Mantequilla/Pasta de Maní puro (sin relleno azucarado)', cantidadMensual: '2 frascos x 500g'),
      ProductoCompra(id: 'g_fib_3', categoria: 'Proteínas Vivas', nombre: 'Cuadril bovino magro o Pechugas de pollo, Yogur Proteico', cantidadMensual: '6 kg asador/plancha cárnico, 15 potes yogur proteico'),
      ProductoCompra(id: 'g_fib_4', categoria: 'Carbohidratos Rústicos Grano', nombre: 'Quinoa fina, Tubérculos (Papas/Batata), Avena y Crackers cuadradas', cantidadMensual: '2 kg Quinoa fina, 4 kg tubérculos, avena 2 kilos bolsa, 6 cajas crackers duras'),
      ProductoCompra(id: 'g_fib_5', categoria: 'Semillas/Verduras', nombre: 'Chía/Lino, Espinacas frondosas (Batidoras)', cantidadMensual: 'Medio kg Chía, Atados espinaca libres demanda'),
    ],
  ),
];

// Semilla de las 5 variantes para "Ganancia Muscular Hombre" (~3000 kcal, Macros: 25% Prot / 50% Carb / 25% Grasas)
final List<DietaModel> dietasGananciaHombre = [
  DietaModel(
    id: 'gan_hombre_estandar',
    titulo: 'Estándar Volumen',
    calorias: 3000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno Campeón', menu: 'Tazón de Avena gruesa hervida con miel, más Huevos revueltos y tostadas.', porciones: '120g avena hidratada, 4 huevos grandes, 2 rebanadas pan extra grueso, 1 cda miel.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Licuado pesado: Proteína, Bananas, Pasta de Maní y Leche entera o al agua.', porciones: '2 Bananas, 2 cdas soperas pasta de maní, 300ml base bebida, 1 scoop de Proteína.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo Masivo', menu: 'Pechuga o Vacuno asado denso + Montaña de Arroz o Pastas + Brócoli/Zanahoria.', porciones: '250g carne/pollo pesado crudo, 150g arroz en seco (rendirá aprox 400g cocido), vegetales libres.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Omelette gigantesco y Pan integral, o sándwich cuádruple de Pavo/Pollo con Palta.', porciones: '4 rebanadas pan grueso integral, 150g pollo desmechado/pavo, 1 palta entera.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Bife ancho al sartén / Cerdo, Puré denso de papa y batata con aceite de oliva.', porciones: '200g bife ancho/cerdo, 300g tubérculos aplastados, base aceite oliva intenso.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'gh_std_1', categoria: 'Proteínas Vivas', nombre: 'Pechugas de Pollo enteras y Cortes bovinos/Cerdos masivos', cantidadMensual: '12 kg pollo, 6 kg carnes (rojas/cerdo) al freezer'),
      ProductoCompra(id: 'gh_std_2', categoria: 'Proteínas Huevos', nombre: 'Huevos en Maple grandes (Tamaño L/XL)', cantidadMensual: '10 maples (300 unidades de huevo)'),
      ProductoCompra(id: 'gh_std_3', categoria: 'Carbohidratos Densos', nombre: 'Sacos de Arroz blanco/integral, Fideos anchos y Tubérculos', cantidadMensual: '6 kg arroz grueso, 6 kg fideos secos, 8 kg papas/batatas'),
      ProductoCompra(id: 'gh_std_4', categoria: 'Carbohidratos y Dulces', nombre: 'Avena instantánea, Pan de Molde grueso, Miel Pura', cantidadMensual: '5 kg avena fardo, 8 panes cuadradísimos, 1 litro Miel pura'),
      ProductoCompra(id: 'gh_std_5', categoria: 'Grasas y Lácteos', nombre: 'Pasta de Maní, Paltas, Leche Entera cajón o Vegetal', cantidadMensual: '2 kg crema de maní, 20 paltas, 15 litros bebida láctea'),
    ],
  ),
  DietaModel(
    id: 'gan_hombre_pesc',
    titulo: 'Pescatariana High-Calorie',
    calorias: 3000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Torre de Pancakes de Avena y Claras + Yogur griego montado de Frutos secos.', porciones: '150g avena instantánea polvo, 6 claras + 1 yema, 200g yogur griego, 50g nueces.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Hummus de Garbanzo a cucharadas con pan árabe integral y aceite de oliva.', porciones: '5 Cdas inmensas puré hummus espeso, 2 panes pita/árabes integrales gigantes, oliva.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo Rústico', menu: 'Rodajas inmensas de Salmón / Filete Atún plano asado + Olla estofada Quinoa-Lentejas pardas.', porciones: '250g Pescado magro/azul, base de 100g quinoa y 80g lentejas en seco hervidas.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Maxi bol proteico: Skyres/Yogur, chía hidratada al espesor, Bananas y cucharones de Maní.', porciones: '300g Skyr o yogur base, 20g chías puras, 2 Bananas, 2 cucharadas pasta maní.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Wraps o Tacos rellenos explotados de Atún y palta + base de Fideos gruesos moñito.', porciones: '3 latas grandotas Atún escurrido, 1 Palta entera, 3 Wraps XXL, 80g de Fideos moñito.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'gh_pesc_1', categoria: 'Proteínas Océano', nombre: 'Filetones gruesos Merluza/Salmón, Atún Natural cajón', cantidadMensual: '10 kg filetes mar, 30 latas al agua pesadas'),
      ProductoCompra(id: 'gh_pesc_2', categoria: 'Proteínas Lácteas', nombre: 'Yogur Griego / Skyr al por mayor, Claras líquidas bi-litro', cantidadMensual: '30 potes inmensos Yogur, 6 Litros en envase de Claras'),
      ProductoCompra(id: 'gh_pesc_3', categoria: 'Carbohidratos Rústicos', nombre: 'Sacos rústicos de Garbanzos y Lentejas pardas', cantidadMensual: '5 kg Garbanzos bolillones, 5 kg Lentejas secas'),
      ProductoCompra(id: 'gh_pesc_4', categoria: 'Carbohidratos', nombre: 'Avena bolson, Quinoa blanca espesa, Pan Pita Integral XL', cantidadMensual: '5 kg avena, 4 kg Quinoa, 8 paquetes Pita/Wraps Integrales'),
      ProductoCompra(id: 'gh_pesc_5', categoria: 'Grasas / Semillas', nombre: 'Pasta Maní cacahuate a kilo, Chía, Nueces y Paltas', cantidadMensual: '2 kg pasta, 1 kg Chía, 1 kg Nueces, 20 Paltas'),
    ],
  ),
  DietaModel(
    id: 'gan_hombre_sinlac',
    titulo: 'Crecimiento Masivo Libre Lácteos',
    calorias: 3000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno Batidora', menu: 'Smoothie colosal de Leche Vegana, 2 Scoops Proteína Aislada (Huevo/Soya), Aceite de Coco y Avena licuada.', porciones: '400ml Bebida vegetal, 2 scoops proteína pura, 1 cda full aceite coco, 120g avena base.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana Fuerte', menu: 'Bloque inmenso estofado de Tofu revuelto + base de galletas de Arroz y Palta cremosa.', porciones: '250g firme tofu escurrido sartén dorado, 6 galletotas XXL arroz grandes, 1 gran palta.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo Masivo', menu: 'Pollo salteado al maní: Pechugas, vegetales wok al vapor y montañas de Batata dulce asada.', porciones: '250g aves crudas magras gruesas, 40g polvo maní/maní entero, 300g tubérculo batata crudo horno.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Huevos hervidos duros, o mega ensalada de Atún + aceite oliva y Lentejas.', porciones: '4 Huevos rotundos al pote o 2 latas atún con base de 100g de lentejas secas al hervidor. 1 Oliva Cda.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Corte puro Cuadril gruesos / Lomo cerdo + puré de Arvejas/Frijol rústico y pan negro.', porciones: '250g bistec res crudo pesado grosero, 100g base arveja/frijol espeso (secos base hervidor), 3 fetas pan negro.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'gh_slac_1', categoria: 'Bebidas Sustitutas', nombre: 'Cajas de Leche de Almendras/Coco sin Azúcar fortificadas', cantidadMensual: '20 cajas de Litro espesas veganas leche.'),
      ProductoCompra(id: 'gh_slac_2', categoria: 'Proteína Asimilación', nombre: 'Tofu Duro Bloque, Tarros Proteina en polvo no láctea (Beef/Soya)', cantidadMensual: '6 kg Tofus de presión en vacío, 2 kilos Suplemento Polvo (2 frascos)'),
      ProductoCompra(id: 'gh_slac_3', categoria: 'Cárnicos', nombre: 'Bifes/Cuadriles y Pollos Magros Gruesos Olas', cantidadMensual: '8 kilos res magra en bistec asador y 8 kilos pollo pechuga'),
      ProductoCompra(id: 'gh_slac_4', categoria: 'Carbohidratos Fibrosos', nombre: 'Avena pura, Batata/Camote dulce, Arveja partida seca', cantidadMensual: '5 kilos avena, 10 kilos Batatas pesadas bolsas, 4 kg Arveja/Frijol ambar rústicos'),
      ProductoCompra(id: 'gh_slac_5', categoria: 'Grasas Altas Calorías', nombre: 'Aceite de Coco denso, Maní crudo y Paltas', cantidadMensual: '2 frascos 500ml Aceite coco, 2 kg maní sueltito y 20 Paltas grandonas verdes'),
    ],
  ),
  DietaModel(
    id: 'gan_hombre_eco',
    titulo: 'Económica Bestial de Volumen',
    calorias: 3000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno', menu: 'Súper tazón de Mazamorra (Avena, agua caliente/leche), Bananas y pan con abundante mantequilla/pasta maní rústica.', porciones: '150g avena barata a agua/leche, 2 Bananas pesadas roldas, 3 panes lactal blancos de oferta con grasa maní.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana', menu: 'Huevos densos hervidos + Fruta de estación.', porciones: '4 huevos grandes duros hervidos, 4 Mandarinas/Naranjas.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo Rudo', menu: 'Tupper Gringo Arroz: Montaña de arroz blanco con Carne picada / aguja molida al puré de tomate.', porciones: '150g arroz blanco (secos), 200g res molición gorda base (aguja especial o magra).'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda', menu: 'Mate/Té abundante + Pan molde fofos y Lentejones sueltos extra saciadores.', porciones: '3 Sábanas panes masivos con dulce, y base gruesa 2 soperas puré maní o base 100g legumbres al tupper.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena', menu: 'Pata musculosa cuarti-muslos peladas hervidas al escurrimiento grueso, estofadas base fideo guisero ancho tirabuzones y lentejas base caldos.', porciones: '300g pollo pata-muslo al cazo, 100g legumbre seca remojadas y un puño grande espeso fideo secos olla fofa barata nutritiva.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'gh_eco_1', categoria: 'Almidones Baratos Supremos', nombre: 'Bolsas masivas Arroz blanco, Avena y Pastas ancha gruesas', cantidadMensual: '10 kg Arroz kilos, 8 kg avena gruesa forrajera, 8 kg fideos hervidor'),
      ProductoCompra(id: 'gh_eco_2', categoria: 'Huevos de Gallina', nombre: 'Huevo Maples inmensos granjeros XL', cantidadMensual: '10 maples colosales (300 unidades de huevos totales)'),
      ProductoCompra(id: 'gh_eco_3', categoria: 'Legumbre Volumen Peso', nombre: 'Bolillones sueltos escurridas Lentejotas rústicas de bolsa sacos puros', cantidadMensual: '6 kg Legumbres estirantes baratas tuppers (lentejas)'),
      ProductoCompra(id: 'gh_eco_4', categoria: 'Proteína Animal Económica', nombre: 'Cajón inmenso Pata-Muslo freezer, y Picada Magra (común o especial) bolsas rojas', cantidadMensual: '12 kg pio pollo cajon a picar/deshebrar, 10 kilos Picada Vacuno'),
      ProductoCompra(id: 'gh_eco_5', categoria: 'Grasas Cacahuateñas', nombre: 'Maní sueltos bolsadas enteros / Pasta cremosa dietéticas de pesaje tacho tupper', cantidadMensual: 'Bolzas sueltas de 4 kilos de crema mantequilla de cacahuate espeso.'),
    ],
  ),
  DietaModel(
    id: 'gan_hombre_fibra',
    titulo: 'Atletas / Alta Densidad Nutritiva',
    calorias: 3000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(horario: '08:00 AM', titulo: 'Desayuno Blender Masivo', menu: 'Licuadora a tope: Avena pulverizada, Leche proteica entera, Scoop Isolate Whey, Aceite y 2 Bananas dulces oscuras maduras.', porciones: '120g avena polvo gruesa licuada rápida, 400ml base bebida, polvo proteína 1 dosis suntuosa, 2 cdas miel pura.'),
      ComidaCronograma(horario: '11:00 AM', titulo: 'Media Mañana Tupper', menu: 'Pudding reposado Chia y Lácteos/Bebida + Pasas de uva / Dátiles altísimos calóricos y nueces.', porciones: '30g Chía estiradas copa o base, 5 Dátiles turcos o 50g pasas uvas y manojones de nueces pacana.'),
      ComidaCronograma(horario: '01:00 PM', titulo: 'Almuerzo Bloque Rudo', menu: 'Bife/Lomo/Asado ancho gigante grosero 3cm espesor rojizo de fuego con mega mega montañas de Fideos espesos oscuros de matriz gruesa o Papa inmensa.', porciones: '250g pesado bovinazo animal a la plancha asador, 200g espesos espagueti o papas masivas grandes verde espesisimo horno ajos.'),
      ComidaCronograma(horario: '05:00 PM', titulo: 'Merienda Sandwich Muros', menu: 'Construccion muros pan negro pan rusticas costroso negro semillas fajas gigantes atun o pollo estufado y palta.', porciones: '4 gigantes panificados moldes cuadrados integrales de atún a la agua grandes en escurrides + Palta gigante entera.'),
      ComidaCronograma(horario: '09:00 PM', titulo: 'Cena Densa Rústica', menu: 'Mega paila de cazuelas estofajeadas leguminosas, 4 claras montadas cocinas cruzadas + rojizo pecho aves martillados blanda digestiones.', porciones: 'El pollo avícola de 150g fijos al estricto finetes hervidores a tu potaje lentejitas sueltotas que estufa grandes a 120g en seco + 4 puras claras densas rústicas.'),
    ],
    listaCompraMensual: [
      ProductoCompra(id: 'gh_fib_1', categoria: 'Secas Densas Fibras Vivas Frutos Calóricos', nombre: 'Dátiles carnosos puritos / uvas pasas, y semillas de Chías o Lino lluvia espesas', cantidadMensual: 'Dietéticas gigantes bolsas de 1 kg batidos dulces Dátileras o pasa y de 1 kg pura chía semillas rústicas polvo alacena.'),
      ProductoCompra(id: 'gh_fib_2', categoria: 'Almidones Nutrientes Lentísimos', nombre: 'Avena instantánea bolsas masivas, Quinoa puritas blanqueada saco 2 kilos tupido y Pan negro amasado.', cantidadMensual: '8 Kilitos polvo puro avena forrajera. 3 Kilitos quinoa fofas lavas sueltas frasco tupido inmenso masivazo moldosos panes densos pesadísimos enteros freezer.'),
      ProductoCompra(id: 'gh_fib_3', categoria: 'Las Vivas Proteínas Cárnicas Pura Musculares', nombre: 'Bifes de Cuadril congelado, O el asador peche pollo finetes grueses / Latona de Atun a puritas mares escurrides.', cantidadMensual: 'El inmenso pollo pechuga animal blanca 8 kilos al frezer cajon / más del res magrísima asados gruesozas rojonas puros a 8 kilazos vacuno musculoso vida tupida y lataza a demanda atunes pescatera marinas proteicotes.'),
    ],
  ),
];
