class Gate
  STATIONS = [:umeda, :juso, :mikuni]
  FARES = [150, 190]

  def initialize(name)
    @name = name
  end

  def enter(ticket) # 引数ticketには金額が渡される
    ticket.stamp(@name) # 引数nameには、入場したGateの名前が渡され、どのGateからいくらのTicketかの情報が入る
  end

  def exit(ticket) # 引数ticketには金額が渡される
    fare = calc_fare(ticket)
    fare <= ticket.fare
  end

  def calc_fare(ticket) # 引数ticketには金額が渡される
    # indexメソッド　引数に合致する要素の添字を取得
    from = STATIONS.index(ticket.stamped_at) # stamped_atに代入された入場駅の名前に対応する添字を取得
    to = STATIONS.index(@name) # 退場する駅の名前に対応する添字を取得
    distance = to - from # 退場駅の添字 - 入場駅の添字 = 距離
    FARES[distance - 1]
  end
end
