var webglOutputBinding = new Shiny.OutputBinding();
$.extend(webglOutputBinding, {
  find: function(scope) {
    return $(scope).find('.shiny-webgl-output');
  },
  renderValue: function(el, data) {
        
    $(el).html(data);
    
    setTimeout(function() { webGLStart(); }, 100);
    //webGLStart();
    
  }
});
Shiny.outputBindings.register(webglOutputBinding, 'trestletech.webglbinding');