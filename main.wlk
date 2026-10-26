import Exception.*

object productora {
  var impuesto = 0.1
  
  method impuesto() = impuesto
  
  method cambiarImpuesto(nuevoImpuesto) {
    impuesto = nuevoImpuesto
  }
  
  method gananciaTotal() {
    
  }
  
  method cantidadEntradas() {
    
  }
  
  method bandaMasPopular() {
    
  }
}

class Entrada {
  const banda //hereda de Banda
  const fecha //hereda de Date
  const precioBase = 1000
  
  method calcularPrecio() = precioBase + (precioBase * productora.impuesto())
  
  method nombreBanda() = banda.nombre()
}
//Creo el error Saldo Negativo para que cuando un Asistente quiera comprar una Entrada y no tiene dinero se notifique en forma de error

class NoPuedoComprar inherits Exception (message = "Saldo negativo") {
  
}

class Asistente {
  const abono
  const historialEntradas = []
  var dinero
  const fechaActual = new Date()
  
  method comprarEntrada(entrada) {
    try {
      if (dinero > 0) {
        dinero -= entrada.calcularPrecio() * (1 - abono.descuento())
        historialEntradas.add(entrada)
      } else {
        throw new NoPuedoComprar()
      }
    } catch error : NoPuedoComprar {
      console.println(error.message())
    }
  }
  
  method entradasSacadasAnioAnterior() = historialEntradas.filter(
    { elemento => elemento.year() == (fechaActual.year() - 1) }
  )
  
  method nombreBandas() = historialEntradas.map(
    { elemento => elemento.nombreBanda() }
  )
}
//Lo hago como una clase porque cada Asistente debe tener su descuento propio y se calcula de forma diferente para cada uno

//Pero fan tiene siempre el mismo comportamiento por lo que puede ser directamente un objeto
//Asistente usa a descuento() como si fueran interfaces
class Vip {
  var property descuento = 0.5
}

object fan {
  method descuento() = 0
}

class Banda {
  const nombre
  
  method canon() = 1000000
  
  method calcularPresupuesto() = self.canon() + self.gastoExtra()
  
  method popularidad()
  
  method gastoExtra()
}

class BandaRock inherits Banda {
  const cantidadSolos
  
  override method gastoExtra() = 10000
  
  override method popularidad() = 100 * cantidadSolos
}

class BandaTrap inherits Banda {
  const tieneHielo
  
  override method gastoExtra() = 0
  
  override method popularidad() {
    if (tieneHielo) {
      return 1000
    } else {
      return 0
    }
  }
  
  override method canon() = super() * self.popularidad()
}

class BandaIndie inherits Banda {
  const cantidadInstrumentos
  
  override method popularidad() = 3.14 * nombre.size()
  
  override method gastoExtra() = 500 * cantidadInstrumentos
}