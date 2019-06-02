$(document).ready(function() {
  rentalsHistoryClickHandlers()
})

const rentalsHistoryClickHandlers = function() {
  $("#rentals-history").on("click", function(e){
    e.preventDefault();
    // history.pushState(null,null, "rentals_history")
    fetch("/rentals.json")
    .then(function(res) {
      return res.json()
    })
    .then(function(rentals) {
      $("#list-rentals-history").html("")
      rentals.forEach(function(rental) {
        let newRental = new Rental(rental)
        let rentalsHistoryHTML = newRental.formatRentalsHistory()
        $("#list-rentals-history").append(rentalsHistoryHTML)
      })
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

Rental.prototype.formatRentalsHistory = function() {

  let custom_start_date = new Date(this.start_date)
  let custom_return_date = new Date(this.return_date)
  let val = `
  <tr>
    <td>${this.id}</td>
    <td><a href="/tools/${this.tool_id}" class="show-tool">${this.tool_name}</a></td>
    <td>${custom_start_date.toDateString()}</td>
    <td>${custom_return_date.toDateString()}</td>
  </tr>
  `
  return val
}
// $(document).ready(function() {
//
//   $("#rentals-history").on("click", function(e){
//     e.preventDefault();
//     $.get("/rentals" + ".json", function(data) {
//
//       data.forEach((el, i) => {
//         let custom_start_date = new Date(el.start_date)
//         let custom_return_date = new Date(el.return_date)
//         // debugger
//         let val = `
//           <tr>
//             <td>${i+1}</td>
//             <td><a href=#>${el.tool.name}</a></td>
//             <td>${custom_start_date.toDateString()}</td>
//             <td>${custom_return_date.toDateString()}</td>
//           </tr>
//         `
//         $("#list-rentals-history").append(val);
//       })
//     })
//   })
// })
