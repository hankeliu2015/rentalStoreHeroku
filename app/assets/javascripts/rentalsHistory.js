$(document).on("turbolinks:load", function() {
  rentalsHistoryClickHandlers()
})

const rentalsHistoryClickHandlers = function() {
  $("#rentals-history").on("click", function(e){
    e.preventDefault();
    $.get("/profile.json", function(user) {

      user.returned_rentals_with_tool_name.forEach(function(rental, i) {
        let newRental = new Rental(rental);
        let rentalHTML = `
          <tr>
            <td> ${i+1} ${newRental.formatRental()} </td>
          </tr>
        `;
        $("#list-rentals-history").append(rentalHTML)
      })
      })
    })
    // repalced by above syntax. The following method for serialize the index.
    // $.get("/rentals.json", function(rentals) {
    //   rentals.forEach(function(rental, i) {
    //     let newRental = new Rental(rental);
    //     let rentalHTML = `
    //       <tr>
    //         <td> ${i+1} ${newRental.formatRental()} </td>
    //       </tr>
    //     `;
    //     $("#list-rentals-history").append(rentalHTML)
    //   })
    // })

  // })

  $(document).on("click", ".show-tool", function(e) {
    e.preventDefault();
    let id = parseInt(this.dataset["toolid"])

    window.location.href = `http://localhost:3000/tools/${id}`;

    //stop render tool show page. instead of redirect to tool show page.
    // fetch(`/tools/${id}.json`)
    // .then(function(res){
    //   return res.json()
    // })
    // .then(function(tool) {
    //   let newTool = new Tool(tool)
    //   let toolHTML = newTool.formatTool()
    //   $(".show-tool").append(toolHTML)
    // })
  })
}

class Rental {
  constructor(rental) {
    this.id = rental[0].id
    this.start_date = rental[0].start_date
    this.return_date = rental[0].return_date
    this.tool_name = rental[2] // tool name nested in the 3rd array of returned_rentals_with_tool_name
    this.tool_id = rental[1]  //tool id nested in the 2nd array.
  }

  formatRental() {

    let custom_start_date = new Date(this.start_date)
    let custom_return_date = new Date(this.return_date)
    let val = `
      <td><a href="/tools/${this.tool_id}" data-toolid="${this.tool_id}" class="show-tool">${this.tool_name}</a></td>
      <td>${custom_start_date.toDateString()}</td>
      <td>${custom_return_date.toDateString()}</td>
    `
    return val
  }
}



// declared Tool class in showTool.js. replace the following Tool function.
// function Tool (tool) {
//   this.id = tool.id
//   this.name = tool.name
//   this.brand = tool.Brand
//   this.description = tool.description
//   this.condition = tool.condition
//   this.rental_price = tool.rental_price
//   this.image = tool.image
// }
//
// Tool.prototype.formatTool = function() {
//   let val = `
//     <h4> ${this.name} </h4>
//     <ul>
//       <li>${this.description} </li>
//       <li>${this.brand} </li>
//       <li>${this.rental_price} </li>
//
//     </ul>
//   `
//   return val
// }
