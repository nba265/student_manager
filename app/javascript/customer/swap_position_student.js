  function setupClickHandlers() {
    $(".btn-up").click(function (e) {
      e.preventDefault();
      var studentId = $(this).data("student-id");
      var prevStudentId = $(this).data("prev-student-id");
      var index = $(this).data("index");
      var prevIndex = $(this).data("prev-index");
      const urlParams = new URLSearchParams(window.location.search);
      const page = urlParams.get("page");
      const deleted = urlParams.get("deleted");

      $.ajax({
        type: "PUT",
        url: "/customers/students/swap_positions",
        data: {
          id: studentId,
          student2_id: prevStudentId,
          authenticity_token: $("meta[name='csrf-token']").attr("content"),
        },
        success: function () {
          // Sau khi hoàn thành yêu cầu Ajax, cập nhật nội dung của hai hàng bị thay đổi
          fetchStudentsData(page,deleted);
        },
      });
    });

    // Xử lý sự kiện khi nhấn nút "⇓" để di chuyển xuống dưới
    $(".btn-down").click(function (e) {
      e.preventDefault();
      var studentId = $(this).data("student-id");
      var nextStudentId = $(this).data("next-student-id");
      var index = $(this).data("index");
      var nextIndex = $(this).data("next-index");
      const urlParams = new URLSearchParams(window.location.search);
      const page = urlParams.get("page"); // Lấy giá trị của 'param1'
      const deleted = urlParams.get("deleted");

      $.ajax({
        type: "PUT",
        url: "/customers/students/swap_positions",
        data: {
          id: studentId,
          student2_id: nextStudentId,
          authenticity_token: $("meta[name='csrf-token']").attr("content"),
        },
        success: function () {
          // Sau khi hoàn thành yêu cầu Ajax, cập nhật nội dung của hai hàng bị thay đổi
          fetchStudentsData(page,deleted);
        },
      });
    });
  }
  function fetchStudentsData(page,deleted) {
    $.ajax({
      url: "/customers/students/reload_student_table", // Điều hướng đến action students_json
      method: "GET",
      dataType: "html",
      data: { page: page, deleted: deleted }, // Truyền số trang cần lấy dữ liệu
      success: function (data) {
        $("#student_table").html(data); // Cập nhật bảng với dữ liệu mới
        setupClickHandlers();
      },
      error: function () {
        console.error("Error fetching data.");
      },
    });
  }
  setupClickHandlers();