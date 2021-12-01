import mongoose from 'mongoose';
const { Schema } = mongoose;



const reviewSchema = new Schema({
  product_id: Number,
  rating: Number,
  summary: String,
  recommend: Boolean,
  response: String,
  body: String,
  date: {type: Date, default: Date.now},
  email: String,
  reviewer_name: String,
  helpfulness: Number,
  photos: [
    {
       url: String
    }
  ]
});

const metaSchema = new Schema({
  product_id: Number,
  ratings: {
    1: Number,
    2: Number,
    3: Number,
    4: Number,
    5: Number
  },
  recommended: {
    true: Number,
    false: Number
  },
  characteristics: Schema.Types.Mixed
});

const models = {
  Review: mongoose.model('Review', reviewSchema),
  Meta: mongoose.model('Meta', metaSchema)
};

export {models};

