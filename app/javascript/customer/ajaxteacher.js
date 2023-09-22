function showEditCourse(){
  $('#course_edit').removeAttr("hidden");
}

function hideEditCourse(){
  $('#course_edit').attr("hidden",true);
}

function showCreateCourse(){
  $('#course_create').removeAttr("hidden");
}

function hideCreateCourse(){
  $('#course_create').attr("hidden",true);
}


$("#teacherDropdown").on("click", function () { 
  $.ajax({
    url: "/customers/courses/get_teachers",
    method: "GET",
    dataType: "json",
    success: function (data) {
      var teacherDropdownMenu = $("#teacherDropdownMenu");
      teacherDropdownMenu.empty();

      teacherDropdownMenu.append(
        '<li><a class="dropdown-item" data-value="">Select teacher</a></li>'
      );

      $.each(data, function (index, teacher) {
        var listItem = $("<li>").append(
          $("<a>")
            .addClass("dropdown-item")
            .attr("data-value", teacher.id)
            .text(teacher.name)
        );
        teacherDropdownMenu.append(listItem);
      });
    },
    error: function () {
    },
  });
});

$("#teacherDropdownMenu").on("click", "li a", function (e) {
  e.preventDefault();
  console.log("click li");
  var selectedTeacherId = $(this).data("value");
  $("#teacherDropdown")
    .attr("data-value", selectedTeacherId)
    .text($(this).text());
});

$("#course_create").on("click", function (e) {
  e.preventDefault();
  let teacherId = $("#teacherDropdown").data("value");
  let courseName = $("#course_name").val();
  console.log(teacherId, courseName);
  $.ajax({
    url: "/customers/courses",
    method: "POST",
    dataType: "json",
    data: {
      course: {
        name: courseName,
        teacher_id: teacherId,
      },  
      authenticity_token: $("meta[name='csrf-token']").attr("content"),
    },
    success: function (data) {
      console.log(data.message);
      $("#teacherDropdown").attr("data-value", "").text("Select teacher");
      $("#course_name").val("");
    },
    error: function (data) {
      console.log(data.responseJSON);
    },
  });
});

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

$(".edit_course").on("click", function(){
  let id = $(this).data("course-id");
  $.ajax({
    url: "/customers/courses/" + id + "/edit",
    method: "GET",
    dataType: "json",
    data: {
      authenticity_token: $("meta[name='csrf-token']").attr("content"),
    },
    success: function (data) {
      $("#teacherDropdown").attr("data-value", data.teacher_id).text(data.teacher_name);
      $("#course_name").val(data.name);
      $("#course_id").val(data.id);
      console.log(data);
    },
    error: function (data) {
      console.log(data.responseJSON);
    },
  });
});

$("#course_edit").on("click", function (e) {
  e.preventDefault();
  let course_id = $("#course_id").val();
  let teacherId = $("#teacherDropdown").data("value");
  let courseName = $("#course_name").val();
  console.log(teacherId, courseName, course_id);
  $.ajax({
    url: "/customers/courses/" + course_id ,
    method: "PUT",
    dataType: "json",
    data: {
      course: {
        name: courseName,
        teacher_id: teacherId,
      },  
      authenticity_token: $("meta[name='csrf-token']").attr("content"),
    },
    success: function (data) {
      console.log(data.message);
      $("#teacherDropdown").attr("data-value", "").text("Select teacher");
      $("#course_name").val("");
      window.location.reload();
    },
    error: function (data) {
      console.log(data.responseJSON);
    },
  });
});
