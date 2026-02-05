<script lang="ts">
	import favicon from '$lib/assets/favicon.svg';

	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" href={favicon} />
	<title>Coolify SvelteKit App</title>
</svelte:head>

<nav>
	<ul>
		<li><a href="/">Home</a></li>
		<li><a href="/abc">ABC Codes</a></li>
	</ul>
</nav>

{@render children()}
