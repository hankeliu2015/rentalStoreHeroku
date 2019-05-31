$(document).ready(function(){
  $('a#discount-rental').on('click', displayRentalForm)
})

function displayRentalForm(e) {
  e.preventDefault();
  let discoutToolId = parseInt(e.target.dataset.toolId) //tool_id not working. 
  console.log(`test display rental form - test tool ID : ${discoutToolId}`)

debugger
  // $('.hidden').html(`<%= j render partial: 'rentals/form', locals: {user_rental: Rental.new(start_date: Date.today, return_date: Date.tomorrow, tool_id:${discoutToolId})} %>`);
}
