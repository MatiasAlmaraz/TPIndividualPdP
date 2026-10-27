import productora.*

class Entrada {
  const banda //hereda de Banda
  const fecha //hereda de Date
  const precioBase = 1000
  
  method calcularPrecio() = precioBase + (precioBase * productora.impuesto())
  
  method nombreBanda() = banda.nombre()
  
  method banda() = banda
}