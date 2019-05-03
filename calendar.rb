require 'date'

class Calendar

    WEEKDAY = [
        'Sun',
        'Mon',
        'Tue',
        'Wed',
        'thu',
        'Fri',
        'Sat',
    ]

    def initialize(month=Date.today().mon(), year=Date.today().year())
        if month.nil? and year.nil?
            @target_date = Date.today()
        else
            @target_date = Date.new(year, month, 1)
        end
    end

    def display()
        # 月初のdateオブジェクトを取得
        first_date = get_first_date()
        # 月末のdateオブジェクトを取得
        last_date = get_last_date()

        calendar = []
        day_per_week = []
        this_month_days = 1..last_date.day()
        index = first_date.wday

        this_month_days.each do |d|
            weeknum = index % WEEKDAY.length

            day_per_week[weeknum] = d
            # rubyはインクリメントが使えない...ぐぬぬ...
            index+=1

            if weeknum == 6
                calendar.push(day_per_week)
                day_per_week = []
            end
        end
        # day_per_weekが空配列でない場合はcalendar配列にpushする
        # これは最終日が土曜日以外の場合のみ実行される
        calendar.push(day_per_week) if day_per_week

        print_calendar(calendar)
    end

    private

    def get_first_date()
        Date.new(@target_date.year, @target_date.month, 1)
    end

    def get_last_date()
        Date.new(@target_date.year, @target_date.month, -1)
    end

    def print_calendar(calendar)
        puts(sprintf("%s %d", @target_date.strftime('%B'), @target_date.year).center(20))

        puts(WEEKDAY.map{|w| w.slice(0,2)}.join(' '))

        calendar.each do |w|
            puts(w.map{|d| "%2s" % d.to_s}.join(' '))
        end
    end
end