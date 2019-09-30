$(document).ready(function(){
  $('a#discount-rental').on('click', displayRentalForm)
})

function displayRentalForm(e) {
  e.preventDefault();
  let discoutToolId = parseInt(e.target.dataset.toolId) //tool_id not working.
  const discountRentForm = $(".hidden").html()    // obtain the hidden form
  $(`#formDiscountRental-${discoutToolId}`).html(discountRentForm) //render the html obtaineed from hidden form
  $(".hidden").html("")
  $(`form`).submit(function(event) {
    // event.preventDefault();
    createDiscountRentalObj(event, discoutToolId)
  })
}

function createDiscountRentalObj(e, idTool) {
  e.preventDefault();
  let value = $(e.target).serializeArray();

  let renting = $.post(`/tools/${idTool}/rentals.json`, value, function(data) {
    let custom_start_date = new Date(data.start_date)
    let custom_return_date = new Date(data.return_date)
    let content = `<p style="color: green" >Tool ${data.tool.name} rented successfully : Start Date: ${custom_start_date.toDateString()}; Return Date: ${custom_return_date.toDateString()} </p>`
    $(`#formDiscountRental-${idTool}`).html(content)
  })

    .fail(function(data) {

    alert( "Tool is not available, please click on Rent button and choose available dates to schedule rental")
    let errorMessage = `<p style="color: maroon">${data.responseJSON.tool[0]}<p>`; //Status Code: ${data.status} unprocessable entity: ${data.statusText}
    $(`#formDiscountRental-${idTool}`).html(errorMessage)
  })

//   // fetch api submit rental form - need rebuild params for rental#create.
  // let valueCSRF = value[1].value
  // debugger
  // fetch(
  //   `/tools/${idTool}/rentals.json`,
  //   {
  //     method: 'POST',
  //     headers: {
  //       // 'X-Requested-With': 'XMLHttpRequest',
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'X-CSRF-Token': valueCSRF
  //     },
  //     body: JSON.stringify(value),  //change to params, serializeArray contains different format.
  //     credentials: 'same-origin'
  //   }
  // ).then(function(res){
  //   // debugger
  //   return res.json()
  // })
  // .then(function(rental) {
  //   debugger  //param is missing or the value is empty: rental
  //   console.log(rental)
  //   let newRental = new Rental(rental)
  //   let rentalHTML = newRental.formatRental()
  //   $(`#formDiscountRental-${idTool}`).html(rentalHTML)
  // })

}
