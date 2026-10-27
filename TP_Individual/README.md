# TP Individual

## Decisiones de diseño

El abono es un objeto separado (composición), no una subclase de Asistente. Un asistente tiene un abono y le delega el cálculo del descuento. Si hubiera hecho AsistenteVip y AsistenteFan, un asistente no podría cambiar de abono sin dejar de ser el mismo objeto, y estaría repitiendo comportamiento entre las dos clases. Con composición, Asistente solo le manda descuento() a su abono sin saber cuál es.

Vip es una clase y fan es un objeto. Cada asistente vip tiene su propio porcentaje de descuento, que además cambia al bonificarlo, así que necesito una instancia con estado para cada uno. En cambio fan nunca tiene descuento ni estado, se comporta siempre igual, así que alcanza con un único objeto.

productora es un objeto único. Hay una sola productora y el impuesto es el mismo para todas las entradas, por eso lo guarda ella y las entradas se lo preguntan en el momento de calcular el precio. Si la productora cambia el impuesto, todas las entradas lo reflejan sin tener que actualizarlas.

Banda es una superclase con métodos abstractos. Todas las bandas tienen nombre, un canon de 1.000.000 y calculan su presupuesto de la misma forma (canon + gastoExtra). Lo que cambia entre tipos de banda es popularidad() y gastoExtra(), así que quedan abstractos en Banda y cada subclase los define. BandaTrap además sobreescribe canon().

El saldo insuficiente se informa con una excepción propia. Creé NoPuedoComprar para que quien intente comprar una entrada sin saldo positivo reciba un error claro, en lugar de que la compra falle sin avisar. Quien llama a comprarEntrada() decide cómo manejarlo.

El historial es una colección de entradas dentro de cada asistente. Así el asistente puede responder por sí mismo qué entradas sacó el año anterior, a qué bandas fue y cuántas entradas tiene para una banda. La productora arma los reportes preguntándole a cada asistente, sin acceder a su historial directamente.

## Conceptos utilizados

1. Polimorfismo

Asistente le envía descuento() y bonificar() a su abono sin saber si es fan o Vip. Cada uno responde a su manera (fan devuelve 0 y no hace nada al bonificar).
productora.bonificarAsistentesVip() le manda bonificarAbono() a todos los asistentes. Los fan lo ignoran sin necesidad de un if que pregunte el tipo.
calcularPresupuesto() y bandaMasPopular() tratan igual a cualquier banda, sea rock, trap o indie.

2. Herencia y métodos abstractos BandaRock, BandaTrap y BandaIndie heredan de Banda el nombre, el canon y el cálculo del presupuesto. popularidad() y gastoExtra() son abstractos porque no existe una implementación razonable para una banda genérica.

3. Composición y delegación

Asistente delega el descuento en su abono.
Entrada delega en la banda para obtener el nombre (nombreBanda()) y en la productora para el impuesto.
productora delega en cada asistente y en cada banda el cálculo de lo que le corresponde a cada uno.

4. Encapsulamiento Los asistentes y las bandas de la productora, el historial de entradas y el dinero no se exponen directamente. Se accede a ellos solo mediante mensajes (showsAsistidos(), cantidadEntradasPara(banda), gastoTotal(), etc.).

## Supuestos y limitaciones

El descuento vip no tiene tope: bonificar muchas veces podría superar el 100%. No lo limité porque la consigna no lo pide.
Si la productora no tiene bandas cargadas, bandaMasPopular() falla porque no hay un máximo para una colección vacía. Si hay bandas pero ninguna vendió entradas, devuelve cualquiera de ellas (todas empatan en 0).
Se considera "año anterior" respecto de la fecha en que se hace la consulta.
