import { query } from '$app/server';
import { env } from '$env/dynamic/private';
import * as odbc from 'odbc';
import * as v from 'valibot';

const abcCodeSchema = v.array(v.object({
  id: v.pipe(v.string(), v.trimEnd()),
  name: v.pipe(v.string(), v.trimEnd()),
  productLine: v.pipe(v.string(), v.trimEnd())
}))

export const getAbcCodes = query(async () => {
  const connection = await odbc.connect(env.DB_CONNECTION);

  const results = await connection.query('SELECT Id AS id, Name AS name, ProductLineId AS productLine FROM Groups');

  await connection.close();

  return v.parse(abcCodeSchema, results);
});
