$(document).ready(function(){
  showToolClickHandlers()
})

const showToolClickHandlers = function(){
  $("#show-tool").on("click", function(e){
    e.preventDefault();
    console.log("inside show tool")
  })
}
