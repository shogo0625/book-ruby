print 'Text?: '
text = gets.chomp
count = 0
# 例外処理を組み込んで再入力可能にする
begin
  count += 1
  print 'Pattern?: '
  pattern = gets.chomp
  regexp = Regexp.new(pattern)
rescue RegexpError => e
  puts "Invalid pattern: #{e.message}"
  retry if count <= 3
  puts "正規表現を勉強してください"
end

matches = text.scan(regexp)
if matches.size > 0
  puts "Matched: #{matches.join(', ')}"
else
  puts "Nothing matched."
end