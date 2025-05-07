function ok($data) {
  echo json_encode(['success'=>true, 'data'=>$data]);
  exit;
}
function err($msg, $code=400) {
  http_response_code($code);
  echo json_encode(['success'=>false, 'error'=>$msg]);
  exit;
}
