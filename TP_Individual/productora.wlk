object productora {
  var impuesto = 0.1
  const asistentes = []
  const bandas = #{}
  
  method impuesto() = impuesto
  
  method cambiarImpuesto(nuevoImpuesto) {
    impuesto = nuevoImpuesto
  }
  
  method presupuestoTotal() = bandas.sum({ banda => banda.calcularPresupuesto() })
  
  method gananciaTotal() = asistentes.sum({ asistente => asistente.gastoTotal() }) - self.presupuestoTotal()
  
  method cantidadEntradas() = asistentes.sum({ asistente => asistente.showsAsistidos() })
  
  method entradasVendidasDe(banda) = asistentes.sum({ asistente => asistente.cantidadEntradasPara(banda) })

  method bandaMasPopular() = bandas.max( {banda => self.entradasVendidasDe(banda)} )

  //Para bonificar a los asistentes Vip recorro la lista de asistentes y por medio de la interfaz bonificarAbono()
  //que es el mensaje que entienden las instancias de Vip y el objeto interfaz fan
  method bonificarAsistentesVip() {
    asistentes.forEach({asistente => asistente.bonificarAbono()})
  }
}