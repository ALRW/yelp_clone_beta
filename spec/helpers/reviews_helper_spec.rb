require 'rails_helper'

def signup_signin
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def signup_signin_user2
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'test2@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def create_restaurant
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  click_button 'Create Restaurant'
end

def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end

describe ReviewsHelper, :type => :helper do
  context '#star_rating' do
    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq('N/A')
    end
    it 'returns five black stars for a five' do
      expect(helper.star_rating(5)).to eq('★★★★★')
    end
    it 'returns three black stars and two white stars for three' do
      expect(helper.star_rating(3)).to eq('★★★☆☆')
    end
    it ' returns four black stars and one white star for 3.5' do
      expect(helper.star_rating(3.5)).to eq('★★★★☆')
    end
  end

  context '#time_ago' do
    it 'can work out the time difference' do
      review = Review.create(thoughts: 'great', rating: '5')
      expect(time_ago(review)).to eq((Time.now - review.created_at).to_i)
    end
  end
  context '#time_since' do
    let(:review){double(:review, thoughts: 'great', rating: '5')}
    it 'can report the number of seconds since a review was created' do
      review1 = Review.create(thoughts: 'great', rating: '5')
      expect(time_since(review1)).to eq("0 seconds ago")
    end
    it 'can report the number of minutes since a review was created' do
      allow(Time).to receive(:now){Time.new(2015,11,26,15,58,20)}
      allow(review).to receive(:created_at){Time.new(2015,11,26,15,53,20)}
      expect(time_since(review)).to eq("5 minutes ago")
    end
    it 'can report the number of hours since a review was created' do
      allow(Time).to receive(:now){Time.new(2015,11,26,15,58,20)}
      allow(review).to receive(:created_at){Time.new(2015,11,26,12,53,20)}
      expect(time_since(review)).to eq("3 hours ago")
    end
    it 'can report the number of days since a review was created' do
      allow(Time).to receive(:now){Time.new(2015,11,26,15,58,20)}
      allow(review).to receive(:created_at){Time.new(2015,11,20,12,53,20)}
      expect(time_since(review)).to eq("6 days ago")
    end
    it 'can report the number of years since a review was created' do
      allow(Time).to receive(:now){Time.new(2015,11,26,15,58,20)}
      allow(review).to receive(:created_at){Time.new(2010,11,20,12,53,20)}
      expect(time_since(review)).to eq("5 years ago")
    end
   end
end
