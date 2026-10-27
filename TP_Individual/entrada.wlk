import productora.*

class Entrada {
  const banda //es de tipo Banda
  const property fecha //es de tipo Date
  const precioBase = 1000
  
  method calcularPrecio() = precioBase + (precioBase * productora.impuesto())
  
  method nombreBanda() = banda.nombre()
  
  method banda() = banda
}