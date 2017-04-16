class BigFiveResultsTextSerializer

  attr_accessor :file, :result, :headers

  def initialize(file)
    @file = file
    @result = {
      "NAME" => "Arnaldo Tayao Jr",
      "EMAIL" => "arnaldotayaojr@gmail.com",
      "EXTRAVERSION" => {
        "Overall Score" => 0,
        "Facets" => {
          "Friendliness" => 0,
          "Gregariousness" => 0,
          "Assertiveness" => 0,
          "Activity Level" => 0,
          "Excitement-Seeking" => 0,
          "Cheerfulness" => 0
        }
      },
      "AGREEABLENESS" => {
        "Overall Score" => 0,
        "Facets" => {
          "Trust" => 0,
          "Morality" => 0,
          "Altruism" => 0,
          "Cooperation" => 0,
          "Modesty" => 0,
          "Sympathy" => 0
        }
      },
      "CONSCIENTIOUSNESS" => {
        "Overall Score" => 0,
        "Facets" => {
          "Self-Efficacy" => 0,
          "Orderliness" => 0,
          "Dutifulness" => 0,
          "Achievement-Striving" => 0,
          "Self-Discipline" => 0,
          "Cautiousness" => 0
        }
      },
      "NEUROTICISM" => {
        "Overall Score" => 0,
        "Facets" => {
          "Anxiety" => 0,
          "Anger" => 0,
          "Depression" => 0,
          "Self-Consciousness" => 0,
          "Immoderation" => 0,
          "Vulnerability" => 0
        }
      },
      "OPENNESS TO EXPERIENCE" => {
        "Overall Score" => 0,
        "Facets" => {
          "Imagination" => 0,
          "Artistic Interests" => 0,
          "Emotionality" => 0,
          "Adventurousness" => 0,
          "Intellect" => 0,
          "Liberalism" => 0
        }
      }
    }

    @headers = ["EXTRAVERSION", "AGREEABLENESS", "CONSCIENTIOUSNESS", "NEUROTICISM", "OPENNESS TO EXPERIENCE"]
  end

  def hash
    current_header = ""

    IO.foreach(File.open(@file)) do |line|
      if line.length == 30
        text = line
        if header?(text.scan(/[\w-]+[a-zA-Z]/).join(" "))
          current_header = text.scan(/[\w-]+[a-zA-Z]/).join(" ")
          @result[current_header]["Overall Score"] = text.scan(/[\d]/)[0].to_i
        else
          @result[current_header]["Facets"][text.scan(/[\w-]+[a-zA-Z]/).join(" ")] = text.scan(/[\d]+/)[0].to_i
        end
      end
    end

    @result
  end

  private

  def header?(line)
    @headers.include?(line)
  end
end
