<script lang="ts">
  import { getRandomNumber, logConnection } from './test.remote';

  async function handleClick() {
    const connection = await logConnection();
    console.log(connection);
  }
</script>

<h1>Welcome to SvelteKit on Coolify</h1>
<p>Visit <a href="https://svelte.dev/docs/kit">svelte.dev/docs/kit</a> to read the documentation</p>

<h2>Random Number: {await getRandomNumber()}</h2>

<button onclick={() => getRandomNumber().refresh()}>
  New Number
</button>

<br>

<button onclick={handleClick}>
  Log Connection
</button>
