class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
     #wdays[0] = '(日)'
     #wdays[1] = '(月)'
     #wdays[2] = '(火)'
     #wdays[3] = '(水)'
     #wdays[4] = '(木)'
     #wdays[5] = '(金)'
     #wdays[6] = '(土)'
    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x 
      end

      wday_num =Date.today.wday + 6
      if wday_num  >=7
        wday_num = wday_num -7
      end


      days = { month: (@todays_date + x).month, date: (@todays_date + x).day,:plans => today_plans, :wday => wdays[x - 6]}
      # ハッシュについてご確認　①キーとバリュー　②シンボル型　③ビューで使用するキーはどれかを確認

      days = { month: (@todays_date + x).month, date: (@todays_date+x).day, plans: today_pla
      @week_days.push(days)
    end

  end
end

#１　48行目の添字があるために火曜日しか表示されない。1週間分の曜日を表示。
# 2  繰り返し処理の中で各曜日を取得する。

#　38行目から51行目までに繰り返し処理のたびに増える値があるそれを探す
# 戻り値である数値を用いて、配列wdaysから曜日の文字列を取得します。
#wday_numが7以上の時に−７　44行目が7以上にならないから44行目を変える。　50行目のx + 1]の中身をかえる
