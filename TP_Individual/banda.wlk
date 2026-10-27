//Creo la superclase Banda de la cual van a heredar comportamiento y atributos los otros
// tipos de bandas
class Banda {
  const property nombre
  
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
    } 
    else {
      return 0
    }
  }
  
  //Uso super porque el metodo esta definido con 1000 pero en las bandas de trap se debe hacer una modificacion a ese valor
  override method canon() = super() * self.popularidad()
}

class BandaIndie inherits Banda {
  const cantidadInstrumentos
  
  override method popularidad() = 3.14 * nombre.size()
  
  override method gastoExtra() = 500 * cantidadInstrumentos
}