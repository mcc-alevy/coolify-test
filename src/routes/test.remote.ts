import { query } from '$app/server';

export const getRandomNumber = query(async () => {
  return Math.floor(Math.random() * 100);
});
