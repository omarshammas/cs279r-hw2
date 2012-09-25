# buttons1 = ["bold-btn", "align_center-btn", "bullet-btn", "web_lyt_btn", "outline_btn", "next-comment-btn"]
# ids1 = [3, 7, 11, 20, 51, 52]
# parents1 = ["home", "home", "home", "view", "view", "review"]
# t1 = [3, 7, 52, 3, 51, 20, 3, 11, 7, 11, 20, 3, 7, 51, 51, 11, 11, 52, 52, 7, 3, 20, 20, 52, 52, 51, 20, 11, 51, 7, 11, 52, 3, 7, 52, 20, 52, 11, 3, 52, 20, 20, 20, 52, 7, 11, 51, 20, 52, 51, 52, 51, 20, 51, 20, 52, 11, 3, 7, 11, 20, 11, 7, 52, 3, 20, 7, 52, 11, 20, 51, 52, 51, 7, 7, 11, 3, 3, 51, 52, 51, 51, 52, 20, 3, 11, 11, 11, 7, 3, 3, 3, 7, 3, 51, 3, 52, 7, 20, 20, 51, 52, 20, 3, 11, 20, 51, 51, 7, 51, 51, 3, 11, 7, 11, 3, 7, 7, 11, 7]

# buttons2 = ["italic-btn", "align_right-btn", "number_list-btn", "table_btn", "pic_btn", "color_btn"]
# ids2 = [4, 12, 8, 28, 29, 40] 
# parents2 = ["home", "home", "home", "insert", "insert", "layout"]
# t2 = [12, 8, 29, 12, 28, 40, 12, 4, 8, 4, 40, 12, 8, 28, 28, 4, 4, 29, 29, 8, 12, 40, 40, 29, 29, 28, 40, 4, 28, 8, 4, 29, 12, 8, 29, 40, 29, 4, 12, 29, 40, 40, 40, 29, 8, 4, 28, 40, 29, 28, 29, 28, 40, 28, 40, 29, 4, 12, 8, 4, 40, 4, 8, 29, 12, 40, 8, 29, 4, 40, 28, 29, 28, 8, 8, 4, 12, 12, 28, 29, 28, 28, 29, 40, 12, 4, 4, 4, 8, 12, 12, 12, 8, 12, 28, 12, 29, 8, 40, 40, 28, 29, 40, 12, 4, 40, 28, 28, 8, 28, 28, 12, 4, 8, 4, 12, 8, 8, 4, 8]

buttons = ["italic-btn", "align_right-btn", "number_list-btn", "table_btn", "pic_btn", "color_btn"]
b = buttons.map { |abr| Button.find_by_abr(abr) }
ids = b.map { |bu| bu.id }

f = (ids*5).shuffle
p = (ids*15).shuffle

count = 0.0
for i in 1..89
  count += 1 if Button.find(p[i]).parent != Button.find(p[i-1]).parent
end

puts b.map { |bu| bu.parent }.inspect
puts f.inspect
puts p.inspect
puts count
puts count/90


