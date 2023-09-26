$(document).ready(function() {

  var activePageLinkHTML= ''

function hideEditCourse() {
  $("#course_edit").attr("hidden", true);
}

function showCreateCourse() {
  $("#course_create").removeAttr("hidden");
}

function hideCreateCourse() {
  $("#course_create").attr("hidden", true);
}

function showEditCourse() {
  $("#course_edit").removeAttr("hidden");
}


function clearCreateForm() {
  $("#teacherDropdown").attr("data-value", "").text("Select Teacher");
  $("#course_name").val("");
  $("#course_id").val("");
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
    error: function () {},
  });
});

$("#teacherDropdownMenu").on("click", "li a", function (e) {
  var selectedTeacherId = $(this).data("value");
  $("#teacherDropdown")
    .data("value", selectedTeacherId)
    .text($(this).text());
});

function setupClickHandlers() {

  $("#course_create").off("click");
  $(".delete_course").off("click");
  $(".edit_course").off("click");
  $("#course_edit").off("click");

  $("#course_create").on("click", function (e) {
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
        load_table_data();
        clearCreateForm();
      },
    });
  });

  $(".delete_course").on("click", function (e) {
    let id = $(this).data("course-id");
    $.ajax({
      url: "/customers/courses/" + id,
      method: "DELETE",
      dataType: "json",
      data: {
        authenticity_token: $("meta[name='csrf-token']").attr("content"),
      },
      success: function (data) {
        load_table_data();
      },
    });
  });
  $(".course_create").on("click", function () {
    hideEditCourse(); 
    showCreateCourse();
    clearCreateForm();
  });
  
  $(".edit_course").on("click", function () {
    hideCreateCourse();
    showEditCourse(); 
    let id = $(this).data("course-id");
    $.ajax({
      url: "/customers/courses/" + id + "/edit",
      method: "GET",
      dataType: "json",
      data: {
        authenticity_token: $("meta[name='csrf-token']").attr("content"),
      },
      success: function (data) {
        $("#teacherDropdown")
          .attr("data-value", data.teacher_id)
          .text(data.teacher_name);
        $("#course_name").val(data.name);
        $("#course_id").val(data.id);
      },
    });
  });

  $("#course_edit").on("click", function (e) {
    e.preventDefault();
    let course_id = $("#course_id").val();
    let teacherId = $("#teacherDropdown").data("value");
    let courseName = $("#course_name").val();
    $.ajax({
      url: "/customers/courses/" + course_id,
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
        load_table_data();
        clearCreateForm();
      },
    });
  });
}

function load_table_data() {
  activePageLinkHTML = $("li.page-item.active a.page-link").html();
  $.ajax({
    url: "/customers/courses/load_table_data",
    method: "GET",
    dataType: "script",
    data: { page: activePageLinkHTML },
    success: function () {  
      setupClickHandlers();
    },
    error: function () {},
  });
}
setupClickHandlers();
});