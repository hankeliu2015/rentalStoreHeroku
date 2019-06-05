$(document).on("turbolinks:load", function() {
  rentalsHistoryClickHandlers()
})

const rentalsHistoryClickHandlers = function() {
  $("#rentals-history").on("click", function(e){
    e.preventDefault();
    $.get("/rentals.json", function(rentals) {
// debugger
      rentals.forEach(function(rental, i) {

        let newRental = new Rental(rental);
        let rentalHTML = `
          <tr>
            <td> ${i+1} ${newRental.formatRental()} </td>
          </tr>
        `;

        $("#list-rentals-history").append(rentalHTML)
      })
    })

    // the following replaced by above jQuery
    // history.pushState(null,null, "rentals_history")
    // fetch("/rentals.json")
    // .then(function(res) {
    //   return res.json()
    // })
    // .then(function(rentals) {
    //   $("#list-rentals-history").html("")
    //   rentals.forEach(function(rental) {
    //     let newRental = new Rental(rental)
    //     let rentalHTML = newRental.formatRental()
    //     $("#list-rentals-history").append(rentalHTML)
    //   })
    // })
  })

  $(document).on("click", ".show-tool", function(e) {
    e.preventDefault();
    // debugger
    let id = parseInt(this.dataset["toolid"])

    fetch(`/tools/${id}.json`)
    .then(function(res){
      return res.json()
    })
    .then(function(tool) {
      console.log(tool)
      let newTool = new Tool(tool)
      let toolHTML = newTool.formatTool()
      $(".show-tool").append(toolHTML)
    })
  })
}

function Rental(rental) {
  this.id = rental.id
  this.tool_name = rental.tool.name
  this.start_date = rental.start_date
  this.return_date = rental.return_date
  this.tool_id = rental.tool.id
}

Rental.prototype.formatRental = function() {

  let custom_start_date = new Date(this.start_date)
  let custom_return_date = new Date(this.return_date)
  let val = `
    <td><a href="/tools/${this.tool_id}" data-toolid="${this.tool_id}" class="show-tool">${this.tool_name}</a></td>
    <td>${custom_start_date.toDateString()}</td>
    <td>${custom_return_date.toDateString()}</td>
  `
  return val
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
      <li>${this.description} </li>
      <li>${this.brand} </li>
      <li>${this.rental_price} </li>

    </ul>
  `
  return val
}
