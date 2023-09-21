$(document).ready(function () {
  $("#course-form").on("click", function (event) {
    $.ajax({
      url: "/customers/courses/get_teachers",
      type: "GET",
      dataType: "json",
      success: function (data) {
        var select = $("select#course_teacher_id");
        select.empty();
        select.append(
          $("<option>", {
            value: "",
            text: "Select a Teacher",
          })
        );
        $.each(data, function (index, teacher) {
          select.append(
            $("<option>", {
              value: teacher.id,
              text: teacher.name,
            })
          );
        });
      },
    });
  });
});
