class TimeConstraint
  def matches?(request) # 引数としてrequestオブジェクトを受け取る
    current = Time.now
    current.hour >= 9 && current < 18 # 戻り値として true/false を返す
  end
end