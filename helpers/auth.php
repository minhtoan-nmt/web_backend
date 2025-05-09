function require_admin() {
    session_start();
    if (empty($_SESSION['is_admin'])) {
        http_response_code(401);
        echo json_encode(['error'=>'Unauthorized']);
        exit;
    }
}
