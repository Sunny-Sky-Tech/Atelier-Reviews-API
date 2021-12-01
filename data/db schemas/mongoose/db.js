import mongoose from 'mongoose';
import {models} from './models';


mongoose.connect('mongodb://localhost:27017/reviews');


const db = {
  saveReview: (data) => {
    // console.log(data);
    const review = new models.Review(data);
    // console.log(review);
    review.save()
    .then((data)=> {console.log(data)})
  },
  saveMeta: (data) => {
    const meta = new models.Meta(data);
    console.log(data);
  }
}

export {db};


