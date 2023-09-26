  function setupClickHandlers() {
    $(".btn-up").click(function (e) {
      e.preventDefault();
      var studentId = $(this).data("student-id");
      var prevStudentId = $(this).data("prev-student-id");
      var fetchData = {};
      const urlParams = new URLSearchParams(window.location.search);
      fetchData["page"]  = urlParams.get("page");
      fetchData["deleted"] = urlParams.get("deleted");
      fetchData["q[name_cont]"] = $('input[name="q[name_cont]"]').val();
      var schoolValues = [];
      $('input[name="q[school_id_in][]"]:checked').each(function(){
        schoolValues.push($(this).val())
      })
      fetchData["q[school_id_in][]"] = schoolValues
      $.ajax({
        type: "PUT",
        url: "/customers/students/swap_positions",
        data: {
          id: studentId,
          student2_id: prevStudentId,
          authenticity_token: $("meta[name='csrf-token']").attr("content"),
        },
        success: function () {
          fetchStudentsData(fetchData);
        },
      });
    });

    $(".btn-down").click(function (e) {
      e.preventDefault();
      var studentId = $(this).data("student-id");
      var nextStudentId = $(this).data("next-student-id");
      var fetchData = {};
      const urlParams = new URLSearchParams(window.location.search);
      fetchData["page"]  = urlParams.get("page");
      fetchData["deleted"] = urlParams.get("deleted");
      fetchData["q[name_cont]"] = $('input[name="q[name_cont]"]').val();
      var schoolValues = [];
      $('input[name="q[school_id_in][]"]:checked').each(function(){
        schoolValues.push($(this).val())
      })
      fetchData["q[school_id_in][]"] = schoolValues

      $.ajax({
        type: "PUT",
        url: "/customers/students/swap_positions",
        data: {
          id: studentId,
          student2_id: nextStudentId,
          authenticity_token: $("meta[name='csrf-token']").attr("content"),
        },
        success: function () {
          fetchStudentsData(fetchData);
        },
      });
    });
  }
  function fetchStudentsData(fetchData) {
    $.ajax({
      url: "/customers/students/reload_student_table", 
      method: "GET",
      dataType: "html",
      data: fetchData,
      success: function (data) {
        $("#student_table").html(data); 
        setupClickHandlers();
      },
      error: function () {
        console.error("Error fetching data.");
      },
    });
  }
  setupClickHandlers();