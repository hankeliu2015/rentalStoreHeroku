$(document).ready(function() {
  rentalsHistoryClickHandlers()
})

const rentalsHistoryClickHandlers = function() {
  $(".rentals-history").on("click", function(e){
    e.preventDefault();
    fetch("/rentals.json")
    .then(function(res) {
      return res.json()
    })
    .then(function(rentals) {
      $(".list-rentals-history").html("")
      rentals.forEach(function(rental) {
        console.log(rental)
      })
    })
  })
}


// $(document).ready(function() {
//
//   $(".rentals-history").on("click", function(e){
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
//         $(".list-rentals-history").append(val);
//       })
//     })
//   })
// })
