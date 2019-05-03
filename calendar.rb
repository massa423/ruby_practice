#!/usr/bin/env ruby

require 'date'

WEEKDAY = {
    Sun: 0,
    Mon: 1,
    Tue: 2,
    Wed: 3,
    thu: 4,
    Fri: 5,
    Sat: 6,
}

def get_first_day_of_the_week(this_year, this_month)
    Date.new(this_year, this_month, 1).strftime('%a')
end

def get_last_day(this_year, this_month)
    Date.new(this_year, this_month + 1, 1).prev_day().day()
end

def print_calendar(calendar, today)
    puts(sprintf("%s %d", today.strftime('%B'), today.year).center(20))

    puts(WEEKDAY.keys().map{|w| w.to_s.slice(0,2)}.join(' '))

    calendar.each do |w|
        puts(w.map{|d| "%2s" % d.to_s}.join(' '))
    end    
end

def main()
    today = Date.today()

    # 月初の曜日を取得
    first_day = get_first_day_of_the_week(today.year(), today.month())
    # 月末の日付を取得
    last_date = get_last_day(today.year(), today.month())

    calendar = []
    day_per_week = []
    this_month_dates = 1..last_date
    index = WEEKDAY[first_day.to_sym]

    this_month_dates.each do |d|
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

    print_calendar(calendar, today)
end

main