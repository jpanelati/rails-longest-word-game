require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test 'Going to root gives us a new random grid to play with' do
    visit root_url
    assert test: 'New game'
    assert_selector 'li', count: 10
  end

  test 'Should return "Use the letters in the grid :("' do
    visit root_url
    fill_in 'text-area', with: 'aaaaaaaaaaaaaaaaaa'
    click_on 'submit'

    assert_text 'Use the letters in the grid :('
  end
end

# You can fill the form with a one-letter consonant word, click play, and get a message it’s not a valid English word
# You can fill the form with a valid English word (that’s hard because there is randomness!), click play and get a “Congratulations” message
