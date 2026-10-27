import Exception.*

//Creo el error Saldo Negativo para que cuando un Asistente quiera comprar una Entrada 
//y no tiene dinero se notifique en forma de error
class NoPuedoComprar inherits Exception (message = "Saldo negativo") {}

class Asistente {
  const tipoAbono
  const historialEntradas = []
  var dinero
  const fechaActual = new Date()
  
  method comprarEntrada(entrada) {
    try {
      if (dinero > 0) {
        dinero -= entrada.calcularPrecio() * (1 - tipoAbono.descuento())
        historialEntradas.add(entrada)
      } 
      else {
        throw new NoPuedoComprar()
      }
    } 
    catch error : NoPuedoComprar {
      console.println(error.message())
    }
  }
  
  method entradasSacadasAnioAnterior() = historialEntradas.filter({ entrada => entrada.fecha().year() == (fechaActual.year() - 1) })
  
  method nombreBandas() = historialEntradas.map({ entrada => entrada.nombreBanda() })
  
  method showsAsistidos() = historialEntradas.size()
  
  method cantidadEntradasPara(banda) = historialEntradas.count({ entrada => entrada.banda() == banda })
  
  method gastoTotal() = historialEntradas.sum({ entrada => entrada.calcularPrecio() })

  method bonificarAbono() {
    tipoAbono.bonificar()
  }
}

//Lo hago como una clase porque cada Asistente debe tener su descuento propio y se calcula de forma diferente para cada uno
//Pero fan tiene siempre el mismo comportamiento por lo que puede ser directamente un objeto
//Asistente usa a descuento() como si fueran interfaces
class Vip {
  var property descuento

  method bonificar() {
    descuento += 0.01
  }
}

object fan {
  method descuento() = 0

  method bonificar(){}
}

