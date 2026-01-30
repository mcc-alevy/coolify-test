<script lang="ts">
  import { getAbcCodes } from './abc.remote';
</script>

<ul>
  {#each await getAbcCodes() as c}
    <li>
      <div>
        <h4>{c.id} - {c.name}</h4>
        <h4>{c.productLine}</h4>
      </div>
    </li>
  {/each}
</ul>
