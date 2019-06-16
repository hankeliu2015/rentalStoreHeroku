$(document).ready(function(){
  $('a#discount-rental').on('click', displayRentalForm)
})

function displayRentalForm(e) {
  e.preventDefault();
  let discoutToolId = parseInt(e.target.dataset.toolId) //tool_id not working.
   // debugger
  const discountRentForm = $(".hidden").html()
  $(`#formDiscountRental-${discoutToolId}`).html(discountRentForm)
  $(".hidden").html("")
  // $.('form')??
  $(`form`).submit(function(event) {
    // event.preventDefault();
    createDiscountRentalObj(event, discoutToolId)
  })
  // do not delete yet.
  // $('.hidden').html(`<%= j render partial: 'rentals/form', locals: {user_rental: Rental.new(start_date: Date.today, return_date: Date.tomorrow, tool_id:${discoutToolId})} %>`);
}

function createDiscountRentalObj(e, idTool) {
  e.preventDefault();
  let value = $(e.target).serializeArray();

//   // fetch api causing unexpected tokent error.
//   let valueCSRF = value[1].value
//   fetch(
//     `/tools/${idTool}/rentals.json`,
//     {
//       method: 'POST',
//       headers: {
//         // 'X-Requested-With': 'XMLHttpRequest',
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'X-CSRF-Token': valueCSRF // giving unexpected token error.
//       },
//       body: JSON.stringify(value),
//       credentials: 'same-origin'
//     }
//   ).then(function(res){
//     debugger
//     return res.json()
//   })
//   .then(function(rental) {
//     console.log(rental)
//     let newRental = new Rental(rental)
//     let rentalHTML = newRental.formatRental()
//     $(`#formDiscountRental-${idTool}`).html(rentalHTML)
//   })
// })

  let renting = $.post(`/tools/${idTool}/rentals.json`, value, function(data) {
    console.log(`${data}`)
    let custom_start_date = new Date(data.start_date)
    let custom_return_date = new Date(data.return_date)
    let content = `<p style="color: green" >Tool ${data.tool.name} rented successfully : Start Date: ${custom_start_date.toDateString()}; Return Date: ${custom_return_date.toDateString()} </p>`
    $(`#formDiscountRental-${idTool}`).html(content)
  }).fail(function() {
    alert( "Tool is not available, please click on Rent button and choose available dates to schedule rental")
  })

} //end of function createDiscountRentalObj
