<?php
function require_admin() {
    // Trong môi trường development, tạm thời bỏ qua kiểm tra admin
    return true;
    
    // TODO: Implement proper admin authentication
    // if (!isset($_SESSION['user']) || $_SESSION['user']['role'] !== 'admin') {
    //     err('Unauthorized', 401);
    // }
}
?> 