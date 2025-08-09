const { MongoClient } = require('mongodb');
const MONGO_USER = process.env.MONGO_USER || 'appuser';
const MONGO_PASSWORD = process.env.MONGO_PASSWORD || 'appuserpassword';
const MONGO_HOST = process.env.MONGO_HOST || '127.0.0.1';
const MONGO_PORT = process.env.MONGO_PORT || '27017';

const uri = `mongodb://${MONGO_USER}:${MONGO_PASSWORD}@${MONGO_HOST}:${MONGO_PORT}/appdb?directConnection=true`;

async function run() {
  const client = new MongoClient(uri, { useUnifiedTopology: true });
  try {
    await client.connect();
    const db = client.db('appdb');
    const products = db.collection('products');
    const randomName = 'Product_' + Math.random().toString(36).substring(2, 10);
    const result = await products.insertOne({ name: randomName, createdAt: new Date() });
    console.log('Inserted product:', result.insertedId, 'with name:', randomName);
  } catch (err) {
    console.error('Error:', err);
  } finally {
    await client.close();
  }
}

run();
