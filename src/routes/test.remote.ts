import { query } from '$app/server';
import { env } from '$env/dynamic/private';

export const getRandomNumber = query(async () => {
  return Math.floor(Math.random() * 100);
});

export const logConnection = query(async () => {
  return env.DB_CONNECTION;
});
