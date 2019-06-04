$(document).on(("turbolinks:load"), function() {
  showToolClickHandlers();
})

// $(document).ready(function(){
//   showToolClickHandlers()
// })

const showToolClickHandlers = function(){
  $("a#show-tool").on("click", function(e){
    e.preventDefault();
    let id = parseInt(this.dataset["toolId"])
    fetch(`tools/${id}.json`)
    .then(function(res) {
      return res.json()
    })
    .then(function(tool){
      $("#tool-container").html("")

      let newTool = new Tool(tool)
      // debugger
      let toolHTML = newTool.formatTool()

      $("#tool-container").html(toolHTML)

      if (newTool.rentalInProgress) {
        let rentalHTML = newTool.formatToolRentalInProgress();
        $("#tool-container").append(rentalHTML)
      } else if (newTool.rentalOverdued) {
        let overduedHTML = newTool.formatToolRentalOverdued();
        $("#tool-container").append(overduedHTML)
      }
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
  this.rentalInProgress = tool.rental_in_progress
  this.rentalOverdued = tool.rental_overdued
}

Tool.prototype.formatTool = function() {
  // debugger
  let val = `
    <h4> ${this.name} </h4>
    <ul>
      <img class="tool_image" src=assets/${this.image}  alt="Tool image" height="100" width="100">
      <li>Description: ${this.description} </li>
      <li>Brand: ${this.brand} </li>
      <li>Rental Price: ${this.rental_price} </li>
      <li>Condition: ${this.condition} </li>
    </ul>
  `
  return val
}

Tool.prototype.formatToolRentalInProgress = function() {
  let customized_start_date = new Date(this.rentalInProgress.start_date)
  let customized_return_date = new Date(this.rentalInProgress.return_date)

  let val = `
    <h6>Tool is not available right now. Please schedule rental dates base on the return date: </h6>

    <li>Rented on: ${customized_start_date.toDateString()} </li>
    <li style="color:maroon">Return Date: ${customized_return_date.toDateString()} </li>
  `
  return val
}

Tool.prototype.formatToolRentalOverdued = function() {
  let startDate = new Date(this.rentalOverdued.start_date)
  let returnDate = new Date(this.rentalOverdued.return_date)
  let todayDate = new Date()

  let val = `
  <h6 style="color:maroon"> Tool is Overdued for: days and not able to rent. Sorry!</h6>
    <li>Rented on: ${startDate.toDateString()}</li>
    <li>Return Date: ${returnDate.toDateString()}</li>
  `
  return val
}
