# ids1 = [3, 7, 11, 15, 22, 46]
# t1 = [3, 7, 22, 3, 15, 46, 3, 11, 7, 11, 46, 3, 7, 15, 15, 11, 11, 22, 22, 7, 3, 46, 46, 22, 22, 15, 46, 11, 15, 7, 11, 22, 3, 7, 22, 46, 22, 11, 3, 22, 46, 46, 46, 22, 7, 11, 15, 46, 22, 15, 22, 15, 46, 15, 46, 22, 11, 3, 7, 11, 46, 11, 7, 22, 3, 46, 7, 22, 11, 46, 15, 22, 15, 7, 7, 11, 3, 3, 15, 22, 15, 15, 22, 46, 3, 11, 11, 11, 7, 3, 3, 3, 7, 3, 15, 3, 22, 7, 46, 46, 15, 22, 46, 3, 11, 46, 15, 15, 7, 15, 15, 3, 11, 7, 11, 3, 7, 7, 11, 7]


# ids2 = [4, 12, 8, 16, 21, 47] 
# t2 = [12, 8, 21, 12, 16, 47, 12, 4, 8, 4, 47, 12, 8, 16, 16, 4, 4, 21, 21, 8, 12, 47, 47, 21, 21, 16, 47, 4, 16, 8, 4, 21, 12, 8, 21, 47, 21, 4, 12, 21, 47, 47, 47, 21, 8, 4, 16, 47, 21, 16, 21, 16, 47, 16, 47, 21, 4, 12, 8, 4, 47, 4, 8, 21, 12, 47, 8, 21, 4, 47, 16, 21, 16, 8, 8, 4, 12, 12, 16, 21, 16, 16, 21, 47, 12, 4, 4, 4, 8, 12, 12, 12, 8, 12, 16, 12, 21, 8, 47, 47, 16, 21, 47, 12, 4, 47, 16, 16, 8, 16, 16, 12, 4, 8, 4, 12, 8, 8, 4, 8]

buttons = ["italic-btn", "align_right-btn", "number_list-btn", "table_btn", "pic_btn", "page_color_btn"]
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


# thesauras.png = 15
# review_track_changes-delete.png = 22
# page_borders.png = 46


# translate.png = 16
# review_track_changes-check.png = 21
# text_wrapping.png = 47



