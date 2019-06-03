$(document).ready(function(){
  showToolClickHandlers()
})

const showToolClickHandlers = function(){
  $("a#show-tool").on("click", function(e){
    e.preventDefault();
    let id = parseInt(this.dataset["toolId"])
    fetch(`tools/${id}.json`)
    .then(function(res) {
      return res.json()
    })
    .then(function(tool){
      console.log(tool)
      $("#tool-container").html("")

      let newTool = new Tool(tool)
      let toolHTML = newTool.formatTool()
      $("#tool-container").html(toolHTML)
    })
  })
}

function Tool (tool) {
  this.id = tool.id
  this.name = tool.name
  this.brand = tool.Brand
  this.description = tool.description
  this.condition = tool.condition
  this.rental_price = tool.rental_price
  this.image = tool.image
}

Tool.prototype.formatTool = function() {
  let val = `
    <h4> ${this.name} </h4>
    <ul>
      <img class="tool_image" src=assets/${this.image}  alt="Tool image" height="120" width="120">
      <li>Description: ${this.description} </li>
      <li>Brand: ${this.brand} </li>
      <li>Rental Price: ${this.rental_price} </li>
      <li>Condition: ${this.condition} </li>

    </ul>
  `
  return val
}
