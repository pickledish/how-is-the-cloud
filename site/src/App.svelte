<script>
  import dayjs from 'dayjs'

  import Tailwindcss from "./Tailwindcss.svelte";
  import Service from './Service.svelte'
</script>

<Tailwindcss />

<main class="w-full h-full py-2 px-2 md:px-32 flex flex-col justify-between">
  <div class="top">
    <h1 class="text-4xl mb-4">
      How is the cloud doing?
    </h1>
    <h3 class="text-xl mb-4">
      Stop being gaslit by ___ status pages and find out if critical cloud services are down via real API calls.
      All times are in your browser's local timezone.
    </h3>
    <div class="w-full flex justify-center">
      <div class="flex flex-col justify-between items-stretch w-full md:w-10/12">
        <Service name="Docker Hub" command="coming soon"/>
        <Service name="Cloudflare" command=""/>
        <Service name="GitHub" command="git clone https://github.com/airbnb/javascript.git"/>
        <Service name="Amazon S3" command="aws s3 ls s3://data.mytransit.nyc/subway_time/2017/"/>
        <Service name="PyPI" command="pip install requests==2.24.0"/>
      </div>
    </div>
  </div>
  <div class="bottom w-full text-center text-sm text-gray-700">
    Static bundle version __buildVersion__ --
    This version built on {dayjs.unix(__buildTime__).format('YYYY-MM-DD ')}
    at {dayjs.unix(__buildTime__).format('h:mm A')} --
    Find the source on <a href="https://github.com/pickledish/how-is-the-cloud">Github</a>
  </div>
</main>
