$(".delete_course").on("click", function(){
    let id = $(this).data("course-id");
    console.log(id);
    $.ajax({
      url: "/customers/courses/" + id,
      method: "DELETE",
      dataType: "json",
      data: {
        authenticity_token: $("meta[name='csrf-token']").attr("content"),
      },
      success: function (data) {
        console.log(data.message);
        window.location.reload();
      },
      error: function (data) {
        console.log(data.responseJSON);
      },
    });
  });