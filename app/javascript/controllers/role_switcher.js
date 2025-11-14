export function RoleSwitcher () {
  document.addEventListener('turbo:load', function() {
    const roleSelect = document.querySelector('.role-field');
    const studentFields = document.querySelectorAll('.student-field');
    const teacherFields = document.querySelectorAll('.teacher-field');
    const adminFields = document.querySelectorAll('.admin-field');
  
    const toggleField = () => {
      const role = roleSelect.value;

      /* role のid に応じて表示する入力欄を変化*/
      studentFields.forEach(field => {
        field.style.display = role === '1' ? 'block' : 'none';
      });

      teacherFields.forEach(field => {
        field.style.display = role === '2' ? 'block' : 'none';
      });

      adminFields.forEach(field => {
        field.style.display = role === '3' ? 'block' : 'none';
      });
    };
    /*初期表示*/
    toggleField();
    /*roleを変更したときにtoggleFieldを再実行する*/
    roleSelect.addEventListener('change', toggleField);
  });
}
