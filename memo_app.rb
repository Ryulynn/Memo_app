
require 'csv'

puts "希望の番号を選択してください。(半角数字で入力してください。)"
puts "1:新規でメモを作成　2:既存のメモを編集"
@get_type = gets.to_i

#クラスの定義
#新規作成時のクラス
class CreateMemo
    def name_file
      puts "新規でメモを作成します。"
      puts "ファイル名を入力し、改行キーを押してください(拡張子は入力しないでください)。"
      @get_name_file = gets
      @get_name_file.chomp!#getsは文末に改行「\n」が入るため消去。
      puts "ファイル中に記載する文字を入力してください。その後「Ctrl + d」を押してください。"
      @get_file_text = readlines
      @get_file_text_chomp = @get_file_text.map{|i| #.mapメソッドで改行が含まれる場合は削除
        if i.include?("\n")
          i.chomp!
        else
          i
        end
        }
    end
    
    def create_file
      CSV.open("#{@get_name_file}.csv","w") do |csv|#csvファイルを作成
        csv << @get_file_text_chomp
      end
　  end
end  

#既存ファイル編集時のクラス
class ChangeMemo
    def file_name
      puts "編集するメモのファイル名を入力してください(拡張子は入力しないでください)。"
      @get_file_name = gets
      @get_file_name.chomp!
      puts "現在のファイル内容は以下です。"
      puts "================================================"
      @get_file_content = CSV.read("#{@get_file_name}.csv")
      puts @get_file_content
      puts "================================================"
      puts "追加で記載する文字列を入力してください。その後「Ctrl + d」を押してください。"
      @get_add_content = readlines
      @get_add_content_chomp = @get_add_content.map{|i| 
        if i.include?("\n")
          i.chomp!
        else
          i
        end
        }
    end
    
    def change_content
      CSV.open("#{@get_file_name}.csv","a") do |csv|#csvファイルに追記（ファイルが存在しない場合は新規作成される。）
        csv << @get_add_content_chomp
      end
    end
end
      
#上記クラスをインスタンス化
@new_file = CreateMemo.new
@change_file = ChangeMemo.new

#選択された内容ごとの処理
if @get_type == 1 then
  puts "1が選択されました。"
  @new_file.name_file
  @new_file.create_file
elsif @get_type == 2 then
  puts "2が選択されました。"
  @change_file.file_name
  @change_file.change_content
else
  puts "1か2で選択してください"
end


puts "\n作業が完了しました。"
puts "終了します。"


