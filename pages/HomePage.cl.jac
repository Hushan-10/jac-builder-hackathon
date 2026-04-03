import from "@jac/runtime" { Link, useNavigate }

# Child components to avoid dynamic dict values as JSX text children

def:pub DestCard(props: dict) -> JsxElement {
    name = props.name or "";
    tag = props.tag or "";
    img = props.img or "";
    to = props.to or "/destinations";

    return (
        <Link
            to={to}
            className="group relative overflow-hidden rounded-[var(--radius-xl)] border border-border shadow-soft hover:shadow-card transition-[box-shadow,transform] duration-300 hover:-translate-y-0.5"
        >
            <div
                className="absolute inset-0"
                style={{"backgroundImage": "url(" + img + ")", "backgroundSize": "cover", "backgroundPosition": "center"}}
            />
            <div className="absolute inset-0 bg-gradient-to-t from-black/55 via-black/10 to-black/0" />
            <div className="relative p-5 min-h-[220px] flex flex-col justify-end">
                <div className="text-white/90 text-xs uppercase tracking-[0.18em]"><span>{tag}</span></div>
                <div className="mt-2 text-white text-xl font-semibold"><span>{name}</span></div>
                <div className="mt-3 inline-flex items-center gap-2 text-sm text-white/85">
                    <span className="h-1.5 w-1.5 rounded-full" style={{"backgroundColor": "var(--color-gold)"}} />
                    <span>Curated experiences</span>
                </div>
            </div>
        </Link>
    );
}


def:pub ExperienceCard(props: dict) -> JsxElement {
    title = props.title or "";
    loc = props.loc or "";
    dur = props.dur or "";
    price = props.price or "";
    cat = props.cat or "";
    img = props.img or "";
    rating = props.rating or 0;
    reviews = props.reviews or 0;

    return (
        <div className="se-glass rounded-[var(--radius-xl)] overflow-hidden">
            <div className="h-44 md:h-48 bg-cover bg-center" style={{"backgroundImage": "url(" + img + ")"}} />
            <div className="p-5">
                <div className="flex items-center justify-between gap-4">
                    <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">
                        <span>{cat}</span>
                        <span>{" • " + dur}</span>
                    </div>
                    <div className="text-sm font-semibold" style={{"color": "var(--color-gold)"}}><span>{price}</span></div>
                </div>
                <div className="mt-2 text-lg font-semibold text-foreground"><span>{title}</span></div>
                <div className="mt-1 text-sm text-muted-foreground"><span>{loc}</span></div>
                <div className="mt-4 flex items-center justify-between gap-3">
                    <div className="text-sm text-foreground/80">
                        <span className="font-semibold">{str(rating)}</span>
                        <span className="text-muted-foreground">{" / 5 • " + str(reviews) + " reviews"}</span>
                    </div>
                    <div className="flex gap-2">
                        <Link to="/experiences" className="h-10 px-4 inline-flex items-center justify-center rounded-xl border border-border bg-white/60 text-sm font-medium hover:bg-white/80 transition-colors">
                            View
                        </Link>
                        <Link to="/experiences" className="h-10 px-4 inline-flex items-center justify-center rounded-xl bg-primary text-primary-foreground text-sm font-medium border border-primary hover:opacity-95 transition-opacity">
                            Book
                        </Link>
                    </div>
                </div>
            </div>
        </div>
    );
}


def:pub CategoryCard(props: dict) -> JsxElement {
    name = props.name or "";
    desc = props.desc or "";
    icon = props.icon or "";

    return (
        <Link to="/experiences" className="group rounded-[var(--radius-lg)] border border-border bg-white/55 hover:bg-white/75 transition-colors p-5">
            <div className="flex items-start justify-between gap-4">
                <div>
                    <div className="text-lg font-semibold"><span>{name}</span></div>
                    <div className="mt-1 text-sm text-muted-foreground leading-relaxed"><span>{desc}</span></div>
                </div>
                <div className="h-10 w-10 rounded-2xl flex items-center justify-center border border-border bg-white/70 text-lg"><span>{icon}</span></div>
            </div>
            <div className="mt-4 text-sm font-medium text-primary inline-flex items-center gap-2">
                <span>Browse</span>
                <span className="group-hover:translate-x-0.5 transition-transform">→</span>
            </div>
        </Link>
    );
}


def:pub TestimonialCard(props: dict) -> JsxElement {
    quote = props.quote or "";
    name = props.name or "";
    meta = props.meta or "";

    return (
        <div className="rounded-[var(--radius-lg)] border border-border bg-white/55 p-5">
            <div className="text-sm leading-relaxed text-foreground/90"><span>{"“" + quote + "”"}</span></div>
            <div className="mt-3 text-xs uppercase tracking-[0.16em] text-muted-foreground"><span>{name}</span></div>
            <div className="mt-1 text-xs text-muted-foreground"><span>{meta}</span></div>
        </div>
    );
}


def:pub page() -> JsxElement {
    hero_img: str = "https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=2400&q=80";

    has destination: str = "";
    has exp_type: str = "";
    has dates: str = "";
    has group_size: str = "";
    has budget: str = "";

    navigate = useNavigate();

    def on_submit(e: any) -> None {
        e.preventDefault();
        navigate("/experiences");
    }

    def on_destination(e: any) -> None { destination = e.target.value; }
    def on_type(e: any) -> None { exp_type = e.target.value; }
    def on_dates(e: any) -> None { dates = e.target.value; }
    def on_group(e: any) -> None { group_size = e.target.value; }
    def on_budget(e: any) -> None { budget = e.target.value; }

    featured_destinations = [
        {"name": "Zermatt", "tag": "Matterhorn", "img": "https://images.unsplash.com/photo-1521295121783-8a321d551ad2?auto=format&fit=crop&w=1600&q=80"},
        {"name": "Interlaken", "tag": "Lakes & peaks", "img": "https://images.unsplash.com/photo-1508182311256-e3f7d1b6c1c8?auto=format&fit=crop&w=1600&q=80"},
        {"name": "Lucerne", "tag": "Old town & lake", "img": "https://images.unsplash.com/photo-1527668752968-14dc70a27c95?auto=format&fit=crop&w=1600&q=80"},
        {"name": "St. Moritz", "tag": "Alpine luxury", "img": "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=1600&q=80"}
    ];

    popular = [
        {"title": "Zermatt Matterhorn Guided Day Tour", "loc": "Zermatt", "dur": "8h", "price": "CHF 290", "rating": 4.9, "reviews": 412, "img": "https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=1600&q=80", "cat": "Mountain"},
        {"title": "Glacier Express Scenic Journey", "loc": "St. Moritz → Zermatt", "dur": "1 day", "price": "CHF 189", "rating": 4.8, "reviews": 980, "img": "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=1600&q=80", "cat": "Train"},
        {"title": "Lucerne Lake Cruise Experience", "loc": "Lucerne", "dur": "2.5h", "price": "CHF 79", "rating": 4.7, "reviews": 633, "img": "https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=1600&q=80", "cat": "Cruise"},
        {"title": "Swiss Chocolate & Culture Tour", "loc": "Zurich", "dur": "3h", "price": "CHF 98", "rating": 4.9, "reviews": 521, "img": "https://images.unsplash.com/photo-1541592106381-b31e9677c0e5?auto=format&fit=crop&w=1600&q=80", "cat": "Food"}
    ];

    categories = [
        {"name": "Mountain Adventures", "desc": "Guided summits, glaciers, and panoramic ridgelines.", "icon": "⛰"},
        {"name": "Scenic Train Trips", "desc": "Cinematic routes through valleys and alpine passes.", "icon": "🚆"},
        {"name": "Lake Cruises", "desc": "Emerald waters, golden-hour decks, and quiet coves.", "icon": "🛥"},
        {"name": "Ski & Snow", "desc": "Powder days, private instructors, and chalet comfort.", "icon": "🎿"},
        {"name": "Food & Chocolate", "desc": "Tastings, ateliers, and Swiss culinary stories.", "icon": "🍫"},
        {"name": "Luxury Stays", "desc": "Boutique hotels, chalets, and lake-view resorts.", "icon": "✨"}
    ];

    testimonials = [
        {"name": "Amelia R.", "quote": "SwissEscape curated a flawless week — every transfer, every view, every detail felt effortless.", "meta": "London • Luxury / Romantic"},
        {"name": "Noah K.", "quote": "The local guide in Lauterbrunnen was incredible. We found hidden waterfalls and quiet trails.", "meta": "Toronto • Adventure"},
        {"name": "Sofia M.", "quote": "The Glacier Express day was pure cinema. The booking flow was smooth and premium.", "meta": "Barcelona • Cultural"}
    ];

    return (
        <div className="min-h-screen se-bg">
            <section className="relative min-h-[100svh] overflow-hidden">
                <div
                    className="absolute inset-0"
                    style={{
                        "backgroundImage": "linear-gradient(180deg, rgba(7,20,39,0.78) 0%, rgba(7,20,39,0.55) 35%, rgba(7,20,39,0.25) 70%, rgba(7,20,39,0.15) 100%), url(" + hero_img + ")",
                        "backgroundSize": "cover",
                        "backgroundPosition": "center"
                    }}
                />

                <div className="relative max-w-6xl mx-auto px-4 pt-6">
                    <nav className="flex items-center justify-between text-white/90">
                        <Link to="/" className="inline-flex items-center gap-3">
                            <div className="h-9 w-9 rounded-xl border border-white/20 bg-white/10 backdrop-blur flex items-center justify-center">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                    <path d="M3 19L12 5l9 14H3Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
                                </svg>
                            </div>
                            <div className="text-xl" style={{"fontFamily": "var(--font-display)"}}>SwissEscape</div>
                        </Link>

                        <div className="hidden md:flex items-center gap-10 text-sm">
                            <Link to="/destinations" className="hover:text-white transition-colors">Destinations</Link>
                            <Link to="/experiences" className="hover:text-white transition-colors">Experiences</Link>
                            <Link to="/stays" className="hover:text-white transition-colors">Stays</Link>
                            <Link to="/dashboard" className="hover:text-white transition-colors">Dashboard</Link>
                        </div>

                        <div className="flex items-center gap-4">
                            <Link to="/login" className="text-sm hover:text-white transition-colors">Sign In</Link>
                            <Link
                                to="/signup"
                                className="h-10 px-5 inline-flex items-center justify-center rounded-full text-sm font-semibold shadow-soft"
                                style={{"backgroundColor": "var(--color-gold)", "color": "rgba(7,20,39,0.95)"}}
                            >
                                Get Started
                            </Link>
                        </div>
                    </nav>
                </div>

                <div className="relative max-w-6xl mx-auto px-4 pt-16 md:pt-24 pb-28 md:pb-36">
                    <div className="text-center">
                        <div className="text-xs uppercase tracking-[0.28em]" style={{"color": "var(--color-gold)"}}>
                            PREMIUM SWISS TRAVEL MARKETPLACE
                        </div>
                        <h1 className="mt-6 text-white leading-[0.98] tracking-[-0.02em] text-5xl md:text-7xl lg:text-8xl" style={{"fontFamily": "var(--font-display)"}}>
                            Discover the Magic of
                            <span className="block" style={{"color": "var(--color-gold)"}}>Switzerland</span>
                        </h1>
                        <p className="mt-6 max-w-3xl mx-auto text-white/85 text-base md:text-lg leading-relaxed">
                            Curated local experiences, scenic journeys, and luxury stays across the Swiss Alps — crafted by locals, loved by travelers.
                        </p>
                    </div>

                    <div className="mt-12 md:mt-14 relative">
                        <div className="mx-auto max-w-5xl">
                            <form
                                onSubmit={on_submit}
                                className="se-glass rounded-full shadow-card border border-white/15 bg-white/70 backdrop-blur px-4 py-3 md:px-6 md:py-4"
                            >
                                <div className="grid grid-cols-1 md:grid-cols-12 gap-3 md:gap-4 items-center">
                                    <div className="md:col-span-3">
                                        <div className="flex items-center gap-3 rounded-full bg-white/60 border border-border px-4 h-12">
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                                <path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 1 1 18 0Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                                <path d="M12 10a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                            </svg>
                                            <input value={destination} onChange={on_destination} placeholder="Where to?" className="w-full bg-transparent text-sm outline-none placeholder:text-muted-foreground" />
                                        </div>
                                    </div>

                                    <div className="md:col-span-3">
                                        <div className="flex items-center gap-3 rounded-full bg-white/60 border border-border px-4 h-12">
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                                <circle cx="11" cy="11" r="7" stroke="currentColor" strokeWidth="2" />
                                                <path d="M20 20l-3.5-3.5" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                            </svg>
                                            <input value={exp_type} onChange={on_type} placeholder="Experience type" className="w-full bg-transparent text-sm outline-none placeholder:text-muted-foreground" />
                                        </div>
                                    </div>

                                    <div className="md:col-span-3">
                                        <div className="flex items-center gap-3 rounded-full bg-white/60 border border-border px-4 h-12">
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                                <rect x="3" y="4" width="18" height="18" rx="2" stroke="currentColor" strokeWidth="2" />
                                                <path d="M16 2v4M8 2v4M3 10h18" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                            </svg>
                                            <input value={dates} onChange={on_dates} placeholder="Travel dates" className="w-full bg-transparent text-sm outline-none placeholder:text-muted-foreground" />
                                        </div>
                                    </div>

                                    <div className="md:col-span-2">
                                        <div className="flex items-center gap-3 rounded-full bg-white/60 border border-border px-4 h-12">
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                                <circle cx="12" cy="7" r="4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                            </svg>
                                            <input value={group_size} onChange={on_group} placeholder="Guests" className="w-full bg-transparent text-sm outline-none placeholder:text-muted-foreground" />
                                        </div>
                                    </div>

                                    <div className="md:col-span-1 flex md:justify-end">
                                        <button
                                            type="submit"
                                            className="h-12 w-full md:w-12 rounded-full inline-flex items-center justify-center font-semibold shadow-soft"
                                            style={{"backgroundColor": "var(--color-gold)", "color": "rgba(7,20,39,0.95)"}}
                                            aria-label="Explore"
                                        >
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <circle cx="11" cy="11" r="7" stroke="currentColor" strokeWidth="2" />
                                                <path d="M20 20l-3.5-3.5" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div className="mt-10 md:mt-12 grid grid-cols-2 md:grid-cols-4 gap-8 text-center text-white/90">
                            <div>
                                <div className="text-2xl md:text-3xl font-semibold">200+</div>
                                <div className="mt-1 text-xs uppercase tracking-[0.18em] text-white/70">Curated Experiences</div>
                            </div>
                            <div>
                                <div className="text-2xl md:text-3xl font-semibold">50+</div>
                                <div className="mt-1 text-xs uppercase tracking-[0.18em] text-white/70">Local Guides</div>
                            </div>
                            <div>
                                <div className="text-2xl md:text-3xl font-semibold">10</div>
                                <div className="mt-1 text-xs uppercase tracking-[0.18em] text-white/70">Swiss Destinations</div>
                            </div>
                            <div>
                                <div className="text-2xl md:text-3xl font-semibold">4.8★</div>
                                <div className="mt-1 text-xs uppercase tracking-[0.18em] text-white/70">Average Rating</div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section className="max-w-6xl mx-auto px-4 py-14 md:py-20">
                <div className="text-center">
                    <div className="text-xs uppercase tracking-[0.28em]" style={{"color": "var(--color-gold)"}}>
                        EXPLORE SWITZERLAND
                    </div>
                    <h2 className="mt-4 text-4xl md:text-5xl leading-[1.05]" style={{"fontFamily": "var(--font-display)"}}>
                        Featured Destinations
                    </h2>
                    <p className="mt-4 text-sm md:text-base text-muted-foreground max-w-2xl mx-auto leading-relaxed">
                        From alpine peaks to lakeside towns, discover the most breathtaking places<br className="hidden md:block" />
                        in Switzerland.
                    </p>
                </div>

                <div className="mt-12 grid grid-cols-1 md:grid-cols-3 gap-7">
                    {[
                        <div key={d["name"]} className="group rounded-[var(--radius-xl)] bg-white/70 border border-border shadow-soft hover:shadow-card transition-[box-shadow,transform] duration-300 hover:-translate-y-1 overflow-hidden">
                            <Link to="/destinations" className="block">
                                <div className="relative overflow-hidden rounded-[var(--radius-xl)]">
                                    <div className="h-64 bg-cover bg-center transition-transform duration-500 group-hover:scale-[1.06]" style={{"backgroundImage": "url(" + d["img"] + ")"}} />
                                    <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-black/15 to-black/0" />

                                    <div className="absolute top-4 right-4">
                                        <div className="px-4 py-2 rounded-full text-xs font-semibold text-white shadow-soft" style={{"backgroundColor": "var(--color-gold)"}}>
                                            <span>{d["badge"]}</span>
                                        </div>
                                    </div>

                                    <div className="absolute left-5 bottom-5">
                                        <div className="text-white text-3xl leading-none" style={{"fontFamily": "var(--font-display)"}}><span>{d["name"]}</span></div>
                                        <div className="mt-1 text-white/85 text-sm"><span>{d["tagline"]}</span></div>
                                    </div>
                                </div>
                            </Link>

                            <div className="px-6 py-6">
                                <div className="flex items-center gap-2 text-sm text-muted-foreground">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                        <path d="M12 22s8-4 8-10V6l-8-4-8 4v6c0 6 8 10 8 10Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                    </svg>
                                    <span>{d["season"]}</span>
                                </div>
                                <p className="mt-3 text-sm text-muted-foreground leading-relaxed">
                                    {d["desc"]}
                                </p>
                                <Link to="/destinations" className="mt-4 inline-flex items-center gap-2 text-sm font-medium" style={{"color": "var(--color-gold)"}}>
                                    Explore
                                    <span className="transition-transform duration-200 group-hover:translate-x-0.5">→</span>
                                </Link>
                            </div>
                        </div>
                        for d in [
                            {
                                "name": "Zermatt",
                                "tagline": "Home of the Matterhorn",
                                "badge": "24 experiences",
                                "season": "Dec–Mar (Ski) / Jun–Sep (Hike)",
                                "desc": "A car-free alpine village at the foot of the iconic Matterhorn, offering world-class skiing, hiking, and cozy chalets.",
                                "img": "https://images.unsplash.com/photo-1521295121783-8a321d551ad2?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "name": "Interlaken",
                                "tagline": "Adventure Capital of Switzerland",
                                "badge": "32 experiences",
                                "season": "Year-round",
                                "desc": "Nestled between Lake Thun and Lake Brienz, Interlaken is the gateway to the Jungfrau region and unforgettable mountain views.",
                                "img": "https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "name": "Lucerne",
                                "tagline": "The Heart of Switzerland",
                                "badge": "28 experiences",
                                "season": "Apr–Oct",
                                "desc": "A picturesque city on Lake Lucerne with a perfectly preserved medieval old town, iconic bridges, and lakeside promenades.",
                                "img": "https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "name": "Zurich",
                                "tagline": "Culture Meets Alpine Charm",
                                "badge": "22 experiences",
                                "season": "Year-round",
                                "desc": "Switzerland's largest city blends cosmopolitan culture, world-class dining, and lakefront living with easy access to alpine escapes.",
                                "img": "https://images.unsplash.com/photo-1520967824495-b529aeba26df?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "name": "Geneva",
                                "tagline": "The Swiss Riviera Gateway",
                                "badge": "18 experiences",
                                "season": "May–Oct",
                                "desc": "An international city on Lake Geneva surrounded by vineyards, offering cultural richness, luxury lakeside promenades, and mountain views.",
                                "img": "https://images.unsplash.com/photo-1506377247377-2a5b3b417ebb?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "name": "Grindelwald",
                                "tagline": "Village at the Foot of the Eiger",
                                "badge": "20 experiences",
                                "season": "Jun–Sep / Dec–Mar",
                                "desc": "A charming mountain village offering dramatic Eiger views, the First cliff walk, and access to iconic Jungfrau-region trails.",
                                "img": "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=2400&q=80&crop=entropy"
                            }
                        ]
                    ]}
                </div>
            </section>

            <section className="max-w-6xl mx-auto px-4 pb-12 md:pb-16">
                <div className="text-center">
                    <div className="text-xs uppercase tracking-[0.28em]" style={{"color": "var(--color-gold)"}}>
                        HANDPICKED FOR YOU
                    </div>
                    <h2 className="mt-4 text-4xl md:text-5xl leading-[1.05]" style={{"fontFamily": "var(--font-display)"}}>
                        Popular Experiences
                    </h2>
                    <p className="mt-4 text-sm md:text-base text-muted-foreground max-w-2xl mx-auto leading-relaxed">
                        Our most loved adventures, tours, and getaways — curated by locals and rated by travelers.
                    </p>
                </div>

                <div className="mt-12 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-7">
                    {[
                        <div key={x["title"]} className="group rounded-[var(--radius-xl)] bg-white/70 border border-border shadow-soft hover:shadow-card transition-[box-shadow,transform] duration-300 hover:-translate-y-1 overflow-hidden flex flex-col">
                            <Link to="/experiences" className="block">
                                <div className="relative overflow-hidden rounded-[var(--radius-xl)] m-4 mb-0">
                                    <div className="h-56 bg-cover bg-center transition-transform duration-500 group-hover:scale-[1.06]" style={{"backgroundImage": "url(" + x["img"] + ")"}} />
                                    <div className="absolute inset-0 bg-gradient-to-t from-black/55 via-black/10 to-black/0" />

                                    <div className="absolute top-4 right-4">
                                        <button className="h-10 w-10 rounded-full bg-white/85 border border-white/60 shadow-soft inline-flex items-center justify-center hover:bg-white transition-colors">
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" className="text-foreground/70">
                                                <path d="M20.8 4.6c-1.5-1.6-4-1.6-5.5 0L12 7.9 8.7 4.6c-1.5-1.6-4-1.6-5.5 0-1.7 1.8-1.7 4.7 0 6.5l8.8 9.2 8.8-9.2c1.7-1.8 1.7-4.7 0-6.5Z" stroke="currentColor" strokeWidth="1.8" strokeLinejoin="round" />
                                            </svg>
                                        </button>
                                    </div>

                                    <div className="absolute left-4 bottom-4 flex flex-wrap gap-2">
                                        {[
                                            <span key={b} className={"px-3 py-1 rounded-full text-xs font-semibold shadow-soft border " + ("bg-white/15 text-white border-white/20" if i > 0 else "text-[rgba(7,20,39,0.95)] border-transparent")} style={{"backgroundColor": ("var(--color-gold)" if i == 0 else "")}}>
                                                {b}
                                            </span>
                                            for (i, b) in enumerate(x["badges"])
                                        ]}
                                    </div>
                                </div>
                            </Link>

                            <div className="px-6 pt-5 pb-6 flex-1 flex flex-col">
                                <div className="flex items-center justify-between gap-4 text-sm text-muted-foreground">
                                    <div className="inline-flex items-center gap-2">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                            <path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 1 1 18 0Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                            <path d="M12 10a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                        </svg>
                                        <span>{x["loc"]}</span>
                                    </div>
                                    <div className="inline-flex items-center gap-2">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                            <circle cx="12" cy="12" r="9" stroke="currentColor" strokeWidth="2" />
                                            <path d="M12 7v5l3 2" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                        </svg>
                                        <span>{x["dur"]}</span>
                                    </div>
                                </div>

                                <div className="mt-3 text-xl leading-snug font-semibold text-foreground" style={{"fontFamily": "var(--font-display)"}}>
                                    <span>{x["title"]}</span>
                                </div>

                                <p className="mt-2 text-sm text-muted-foreground leading-relaxed line-clamp-2">
                                    {x["desc"]}
                                </p>

                                <div className="mt-5 flex items-center justify-between gap-4">
                                    <div className="inline-flex items-center gap-2 text-sm">
                                        <span style={{"color": "var(--color-gold)"}}>★</span>
                                        <span className="font-semibold text-foreground">{x["rating"]}</span>
                                        <span className="text-muted-foreground">{"(" + x["reviews"] + ")"}</span>
                                    </div>
                                    <div className="text-sm text-muted-foreground">
                                        <span>from </span>
                                        <span className="font-semibold text-foreground" style={{"fontFamily": "var(--font-display)"}}>{"CHF " + x["price"]}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        for x in [
                            {
                                "title": "Zermatt Matterhorn Guided Day Tour",
                                "loc": "Zermatt",
                                "dur": "8 hours",
                                "rating": "4.9",
                                "reviews": "342",
                                "price": "189",
                                "badges": ["Mountain Tours"],
                                "desc": "Explore the iconic Matterhorn with an expert alpine guide. Summit views, glacier walks, and village stories.",
                                "img": "https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "title": "Interlaken Adventure Pass",
                                "loc": "Interlaken",
                                "dur": "Full day",
                                "rating": "4.8",
                                "reviews": "518",
                                "price": "249",
                                "badges": ["Adventure"],
                                "desc": "The ultimate Swiss adventure day — paragliding, canyon jumping, and river rafting in the heart of the Alps.",
                                "img": "https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "title": "Lucerne Lake Cruise Experience",
                                "loc": "Lucerne",
                                "dur": "4 hours",
                                "rating": "4.7",
                                "reviews": "423",
                                "price": "89",
                                "badges": ["Lake Cruises", "Luxury"],
                                "desc": "Cruise across Lake Lucerne aboard a classic paddle steamer, enjoying panoramic mountain views and lakeside charm.",
                                "img": "https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "title": "Glacier Express Scenic Journey",
                                "loc": "St. Moritz → Zermatt",
                                "dur": "Full day",
                                "rating": "4.8",
                                "reviews": "980",
                                "price": "189",
                                "badges": ["Luxury"],
                                "desc": "Ride the legendary red train across snowy bridges and alpine passes — reserved panoramic seats included.",
                                "img": "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "title": "St. Moritz Alpine Spa Escape",
                                "loc": "St. Moritz",
                                "dur": "Full day",
                                "rating": "4.9",
                                "reviews": "211",
                                "price": "399",
                                "badges": ["Wellness", "Luxury"],
                                "desc": "Unwind in a luxury mountain spa with heated pools, sauna rituals, and panoramic alpine views.",
                                "img": "https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "title": "Grindelwald Chalet Retreat",
                                "loc": "Grindelwald",
                                "dur": "Full day",
                                "rating": "4.8",
                                "reviews": "176",
                                "price": "229",
                                "badges": ["Luxury"],
                                "desc": "Cozy up in a chalet with floor-to-ceiling mountain views — fireside comfort, local treats, and alpine serenity.",
                                "img": "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=2400&q=80"
                            }
                        ]
                    ]}
                </div>

                <div className="mt-10 text-center">
                    <Link to="/experiences" className="inline-flex items-center gap-2 text-sm font-medium" style={{"color": "var(--color-gold)"}}>
                        Browse all experiences
                        <span>→</span>
                    </Link>
                </div>
            </section>

            <section className="max-w-6xl mx-auto px-4 pb-12 md:pb-16">
                <div className="text-center">
                    <div className="text-xs uppercase tracking-[0.28em]" style={{"color": "var(--color-gold)"}}>
                        EXPLORE YOUR WAY
                    </div>
                    <h2 className="mt-5 text-4xl md:text-6xl leading-[1.02] tracking-[-0.02em]" style={{"fontFamily": "var(--font-display)"}}>
                        Browse by Category
                    </h2>
                    <p className="mt-5 max-w-3xl mx-auto text-base md:text-lg text-muted-foreground leading-relaxed">
                        From adrenaline-pumping adventures to serene wellness retreats — find the Swiss experience that speaks to you.
                    </p>
                </div>

                <div className="mt-12 md:mt-14 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-6">
                    <Link
                        to="/experiences"
                        className="group relative overflow-hidden rounded-[var(--radius-xl)] shadow-card hover:shadow-soft transition-[box-shadow,transform] duration-300 hover:-translate-y-0.5 md:col-span-1 lg:col-span-5 lg:row-span-2 min-h-[320px] lg:min-h-[520px]"
                    >
                        <div
                            className="absolute inset-0 bg-cover bg-center transition-transform duration-500 group-hover:scale-[1.06]"
                            style={{"backgroundImage": "url(https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=2400&q=80)"}}
                        />
                        <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-black/0" />
                        <div className="relative h-full p-7 flex flex-col justify-end">
                            <div className="text-2xl"><span>⛰️</span></div>
                            <div className="mt-3 text-3xl md:text-4xl font-semibold text-white" style={{"fontFamily": "var(--font-display)"}}>
                                Mountain Tours
                            </div>
                            <div className="mt-2 text-sm text-white/80">18 experiences</div>
                        </div>
                    </Link>

                    <Link
                        to="/experiences"
                        className="group relative overflow-hidden rounded-[var(--radius-xl)] shadow-card hover:shadow-soft transition-[box-shadow,transform] duration-300 hover:-translate-y-0.5 min-h-[220px] lg:col-span-3"
                    >
                        <div
                            className="absolute inset-0 bg-cover bg-center transition-transform duration-500 group-hover:scale-[1.06]"
                            style={{"backgroundImage": "url(https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=2400&q=80)"}}
                        />
                        <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-black/0" />
                        <div className="relative h-full p-6 flex flex-col justify-end">
                            <div className="text-2xl"><span>🚆</span></div>
                            <div className="mt-3 text-2xl font-semibold text-white" style={{"fontFamily": "var(--font-display)"}}>
                                Scenic Trains
                            </div>
                            <div className="mt-2 text-sm text-white/80">8 experiences</div>
                        </div>
                    </Link>

                    <Link
                        to="/experiences"
                        className="group relative overflow-hidden rounded-[var(--radius-xl)] shadow-card hover:shadow-soft transition-[box-shadow,transform] duration-300 hover:-translate-y-0.5 min-h-[220px] lg:col-span-4"
                    >
                        <div
                            className="absolute inset-0 bg-cover bg-center transition-transform duration-500 group-hover:scale-[1.06]"
                            style={{"backgroundImage": "url(https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=2400&q=80)"}}
                        />
                        <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-black/0" />
                        <div className="relative h-full p-6 flex flex-col justify-end">
                            <div className="text-2xl"><span>🛥️</span></div>
                            <div className="mt-3 text-2xl font-semibold text-white" style={{"fontFamily": "var(--font-display)"}}>
                                Lake Cruises
                            </div>
                            <div className="mt-2 text-sm text-white/80">12 experiences</div>
                        </div>
                    </Link>

                    <Link
                        to="/experiences"
                        className="group relative overflow-hidden rounded-[var(--radius-xl)] shadow-card hover:shadow-soft transition-[box-shadow,transform] duration-300 hover:-translate-y-0.5 min-h-[220px] lg:col-span-3"
                    >
                        <div
                            className="absolute inset-0 bg-cover bg-center transition-transform duration-500 group-hover:scale-[1.06]"
                            style={{"backgroundImage": "url(https://images.unsplash.com/photo-1541592106381-b31e9677c0e5?auto=format&fit=crop&w=2400&q=80)"}}
                        />
                        <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-black/0" />
                        <div className="relative h-full p-6 flex flex-col justify-end">
                            <div className="text-2xl"><span>🍫</span></div>
                            <div className="mt-3 text-2xl font-semibold text-white" style={{"fontFamily": "var(--font-display)"}}>
                                Food & Culture
                            </div>
                            <div className="mt-2 text-sm text-white/80">10 experiences</div>
                        </div>
                    </Link>

                    <Link
                        to="/experiences"
                        className="group relative overflow-hidden rounded-[var(--radius-xl)] shadow-card hover:shadow-soft transition-[box-shadow,transform] duration-300 hover:-translate-y-0.5 min-h-[220px] lg:col-span-4"
                    >
                        <div
                            className="absolute inset-0 bg-cover bg-center transition-transform duration-500 group-hover:scale-[1.06]"
                            style={{"backgroundImage": "url(https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=2400&q=80)"}}
                        />
                        <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-black/0" />
                        <div className="relative h-full p-6 flex flex-col justify-end">
                            <div className="text-2xl"><span>🪂</span></div>
                            <div className="mt-3 text-2xl font-semibold text-white" style={{"fontFamily": "var(--font-display)"}}>
                                Adventure
                            </div>
                            <div className="mt-2 text-sm text-white/80">14 experiences</div>
                        </div>
                    </Link>

                    <Link
                        to="/experiences"
                        className="group relative overflow-hidden rounded-[var(--radius-xl)] shadow-card hover:shadow-soft transition-[box-shadow,transform] duration-300 hover:-translate-y-0.5 min-h-[220px] lg:col-span-5"
                    >
                        <div
                            className="absolute inset-0 bg-cover bg-center transition-transform duration-500 group-hover:scale-[1.06]"
                            style={{"backgroundImage": "url(https://images.unsplash.com/photo-1482192596544-9eb780fc7f66?auto=format&fit=crop&w=2400&q=80)"}}
                        />
                        <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-black/0" />
                        <div className="relative h-full p-6 flex flex-col justify-end">
                            <div className="text-2xl"><span>🎿</span></div>
                            <div className="mt-3 text-2xl font-semibold text-white" style={{"fontFamily": "var(--font-display)"}}>
                                Ski & Snow
                            </div>
                            <div className="mt-2 text-sm text-white/80">9 experiences</div>
                        </div>
                    </Link>
                </div>
            </section>

            <section className="max-w-6xl mx-auto px-4 py-16 md:py-20">
                <div className="text-center">
                    <div className="text-xs uppercase tracking-[0.28em]" style={{"color": "var(--color-gold)"}}>
                        THE SWISSESCAPE DIFFERENCE
                    </div>
                    <h2 className="mt-5 text-4xl md:text-5xl leading-[1.05]" style={{"fontFamily": "var(--font-display)"}}>
                        Why Travel With Us
                    </h2>
                </div>

                <div className="mt-12 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <div className="rounded-[var(--radius-xl)] bg-white shadow-card border border-border p-7 text-center">
                        <div className="mx-auto h-14 w-14 rounded-2xl flex items-center justify-center bg-muted" style={{"color": "var(--color-gold)"}}>
                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 1 1 18 0Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                <path d="M12 10a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                            </svg>
                        </div>
                        <div className="mt-6 text-lg font-semibold" style={{"fontFamily": "var(--font-display)"}}>Curated by Locals</div>
                        <div className="mt-3 text-sm text-muted-foreground leading-relaxed">
                            Every experience is handpicked and hosted by passionate Swiss locals who know their region inside out.
                        </div>
                    </div>

                    <div className="rounded-[var(--radius-xl)] bg-white shadow-card border border-border p-7 text-center">
                        <div className="mx-auto h-14 w-14 rounded-2xl flex items-center justify-center bg-muted" style={{"color": "var(--color-gold)"}}>
                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2l7 4v6c0 5-3 9-7 10-4-1-7-5-7-10V6l7-4Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
                            </svg>
                        </div>
                        <div className="mt-6 text-lg font-semibold" style={{"fontFamily": "var(--font-display)"}}>Verified & Trusted</div>
                        <div className="mt-3 text-sm text-muted-foreground leading-relaxed">
                            All guides and vendors are verified. Every booking is protected with our satisfaction guarantee.
                        </div>
                    </div>

                    <div className="rounded-[var(--radius-xl)] bg-white shadow-card border border-border p-7 text-center">
                        <div className="mx-auto h-14 w-14 rounded-2xl flex items-center justify-center bg-muted" style={{"color": "var(--color-gold)"}}>
                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2v4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                <path d="M12 18v4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                <path d="M4 12H2" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                <path d="M22 12h-2" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                <path d="M19.78 4.22l-1.42 1.42" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                <path d="M5.64 18.36l-1.42 1.42" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                <path d="M19.78 19.78l-1.42-1.42" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                <path d="M5.64 5.64L4.22 4.22" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                <path d="M12 7a5 5 0 1 0 0 10 5 5 0 0 0 0-10Z" stroke="currentColor" strokeWidth="2" />
                            </svg>
                        </div>
                        <div className="mt-6 text-lg font-semibold" style={{"fontFamily": "var(--font-display)"}}>AI-Powered Planning</div>
                        <div className="mt-3 text-sm text-muted-foreground leading-relaxed">
                            Our AI itinerary builder creates personalized Swiss travel plans tailored to your style and budget.
                        </div>
                    </div>

                    <div className="rounded-[var(--radius-xl)] bg-white shadow-card border border-border p-7 text-center">
                        <div className="mx-auto h-14 w-14 rounded-2xl flex items-center justify-center bg-muted" style={{"color": "var(--color-gold)"}}>
                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M16 11c1.66 0 3-1.34 3-3S17.66 5 16 5s-3 1.34-3 3 1.34 3 3 3Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                <path d="M8 11c1.66 0 3-1.34 3-3S9.66 5 8 5 5 6.34 5 8s1.34 3 3 3Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                <path d="M2 19c0-2.21 1.79-4 4-4h4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                <path d="M14 15h4c2.21 0 4 1.79 4 4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                            </svg>
                        </div>
                        <div className="mt-6 text-lg font-semibold" style={{"fontFamily": "var(--font-display)"}}>Small Group Focus</div>
                        <div className="mt-3 text-sm text-muted-foreground leading-relaxed">
                            Intimate group sizes ensure authentic, personal experiences far from tourist crowds.
                        </div>
                    </div>
                </div>
            </section>

            <section className="py-16 md:py-20" style={{"backgroundColor": "#071427"}}>
                <div className="max-w-6xl mx-auto px-4">
                    <div className="text-center">
                        <div className="text-xs uppercase tracking-[0.28em]" style={{"color": "var(--color-gold)"}}>
                            TRAVELER STORIES
                        </div>
                        <h2 className="mt-5 text-4xl md:text-5xl text-white leading-[1.05]" style={{"fontFamily": "var(--font-display)"}}>
                            What Our Travelers Say
                        </h2>
                    </div>

                    <div className="mt-12 grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div className="rounded-[var(--radius-xl)] p-7 border" style={{"backgroundColor": "rgba(255,255,255,0.06)", "borderColor": "rgba(255,255,255,0.10)"}}>
                            <div className="text-sm tracking-[0.12em]" style={{"color": "var(--color-gold)"}}>★★★★★</div>
                            <div className="mt-4 text-sm leading-relaxed text-white/85">
                                “SwissEscape planned every detail perfectly — the Glacier Express day felt like a movie from start to finish.”
                            </div>
                            <div className="mt-6 text-white font-semibold">Sarah M.</div>
                            <div className="mt-1 text-sm text-white/70">London, UK</div>
                            <div className="mt-3 text-sm" style={{"color": "var(--color-gold)"}}>Glacier Express Journey</div>
                        </div>

                        <div className="rounded-[var(--radius-xl)] p-7 border" style={{"backgroundColor": "rgba(255,255,255,0.06)", "borderColor": "rgba(255,255,255,0.10)"}}>
                            <div className="text-sm tracking-[0.12em]" style={{"color": "var(--color-gold)"}}>★★★★★</div>
                            <div className="mt-4 text-sm leading-relaxed text-white/85">
                                “Our guide in Interlaken was incredible. We discovered hidden viewpoints and quiet trails away from the crowds.”
                            </div>
                            <div className="mt-6 text-white font-semibold">Noah K.</div>
                            <div className="mt-1 text-sm text-white/70">Toronto, CA</div>
                            <div className="mt-3 text-sm" style={{"color": "var(--color-gold)"}}>Interlaken Adventure Day</div>
                        </div>

                        <div className="rounded-[var(--radius-xl)] p-7 border" style={{"backgroundColor": "rgba(255,255,255,0.06)", "borderColor": "rgba(255,255,255,0.10)"}}>
                            <div className="text-sm tracking-[0.12em]" style={{"color": "var(--color-gold)"}}>★★★★★</div>
                            <div className="mt-4 text-sm leading-relaxed text-white/85">
                                “The lake cruise in Lucerne was pure serenity. Everything felt premium, seamless, and beautifully curated.”
                            </div>
                            <div className="mt-6 text-white font-semibold">Amelia R.</div>
                            <div className="mt-1 text-sm text-white/70">Barcelona, ES</div>
                            <div className="mt-3 text-sm" style={{"color": "var(--color-gold)"}}>Lake Lucerne Cruise</div>
                        </div>
                    </div>
                </div>
            </section>

            <footer className="border-t border-border bg-white/70">
                <div className="max-w-6xl mx-auto px-4 py-10">
                    <div className="grid grid-cols-1 md:grid-cols-12 gap-8">
                        <div className="md:col-span-5">
                            <div className="text-xl" style={{"fontFamily": "var(--font-display)"}}>SwissEscape</div>
                            <p className="mt-2 text-sm text-muted-foreground max-w-md">
                                A premium marketplace for Swiss experiences, stays, and cinematic journeys — curated by locals.
                            </p>
                            <div className="mt-5 se-glass rounded-[var(--radius-lg)] p-4">
                                <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Newsletter</div>
                                <div className="mt-2 flex gap-2">
                                    <input className="flex-1 h-10 rounded-xl border border-border bg-white/60 px-3 text-sm outline-none" placeholder="Email address" />
                                    <button className="h-10 px-4 rounded-xl bg-primary text-primary-foreground text-sm font-medium border border-primary hover:opacity-95 transition-opacity">Join</button>
                                </div>
                            </div>
                        </div>
                        <div className="md:col-span-7 grid grid-cols-2 sm:grid-cols-3 gap-6">
                            <div>
                                <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Explore</div>
                                <div className="mt-3 flex flex-col gap-2">
                                    <Link to="/destinations" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Destinations</Link>
                                    <Link to="/experiences" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Experiences</Link>
                                    <Link to="/stays" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Stays</Link>
                                </div>
                            </div>
                            <div>
                                <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Company</div>
                                <div className="mt-3 flex flex-col gap-2">
                                    <Link to="/host" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Become a host</Link>
                                    <Link to="/support" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Support</Link>
                                    <Link to="/support" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Contact</Link>
                                </div>
                            </div>
                            <div>
                                <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Account</div>
                                <div className="mt-3 flex flex-col gap-2">
                                    <Link to="/login" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Login</Link>
                                    <Link to="/dashboard" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Dashboard</Link>
                                    <Link to="/admin" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Admin</Link>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="mt-10 flex flex-col md:flex-row md:items-center md:justify-between gap-3 text-xs text-muted-foreground">
                        <div>© SwissEscape • Switzerland travel marketplace</div>
                        <div className="flex gap-4">
                            <a className="hover:text-foreground transition-colors" href="#">Instagram</a>
                            <a className="hover:text-foreground transition-colors" href="#">YouTube</a>
                            <a className="hover:text-foreground transition-colors" href="#">X</a>
                        </div>
                    </div>
                </div>
            </footer>

            <section className="max-w-6xl mx-auto px-4 pb-16">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div className="rounded-[28px] border border-border shadow-card p-10 md:p-12" style={{"background": "linear-gradient(180deg, rgba(245,236,220,0.85) 0%, rgba(250,247,241,0.9) 100%)"}}>
                        <div className="h-12 w-12 rounded-2xl flex items-center justify-center border border-border bg-white/70">
                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                <path d="M12 2l1.6 5.2L19 9l-5.4 1.8L12 16l-1.6-5.2L5 9l5.4-1.8L12 2Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
                                <path d="M20 14l.9 2.8L24 18l-3.1 1.2L20 22l-.9-2.8L16 18l3.1-1.2L20 14Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" opacity="0.55" />
                            </svg>
                        </div>
                        <h3 className="mt-7 text-3xl md:text-4xl leading-tight tracking-[-0.01em]" style={{"fontFamily": "var(--font-display)"}}>
                            Build Your Dream Itinerary
                        </h3>
                        <p className="mt-4 text-base md:text-lg leading-relaxed text-muted-foreground max-w-[34rem]">
                            Let our AI craft a personalized Switzerland trip based on your interests, budget, and travel style.
                        </p>
                        <div className="mt-8">
                            <Link
                                to="/dashboard"
                                className="h-12 px-7 inline-flex items-center justify-center rounded-2xl text-sm font-semibold shadow-soft"
                                style={{"backgroundColor": "var(--color-gold)", "color": "rgba(7,20,39,0.95)"}}
                            >
                                Start Planning
                            </Link>
                        </div>
                    </div>

                    <div className="rounded-[28px] border border-border shadow-card p-10 md:p-12" style={{"background": "linear-gradient(180deg, rgba(235,238,242,0.95) 0%, rgba(246,248,250,0.95) 100%)"}}>
                        <div className="h-12 w-12 rounded-2xl flex items-center justify-center border border-border bg-white/70">
                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "rgba(7,20,39,0.9)"}}>
                                <path d="M3 20h18" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                <path d="M5 20l6-12 4 8 2-4 2 8" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
                            </svg>
                        </div>
                        <h3 className="mt-7 text-3xl md:text-4xl leading-tight tracking-[-0.01em]" style={{"fontFamily": "var(--font-display)"}}>
                            Become a Local Host
                        </h3>
                        <p className="mt-4 text-base md:text-lg leading-relaxed text-muted-foreground max-w-[34rem]">
                            Share your passion for Switzerland. List your experiences and connect with travelers from around the world.
                        </p>
                        <div className="mt-8">
                            <Link
                                to="/host"
                                className="h-12 px-7 inline-flex items-center justify-center rounded-2xl text-sm font-semibold border"
                                style={{"borderColor": "rgba(7,20,39,0.9)", "color": "rgba(7,20,39,0.9)", "backgroundColor": "rgba(255,255,255,0.55)"}}
                            >
                                Learn More
                            </Link>
                        </div>
                    </div>
                </div>
            </section>

            <footer className="w-full" style={{"backgroundColor": "rgba(7,20,39,0.98)", "color": "rgba(255,255,255,0.86)"}}>
                <div className="max-w-6xl mx-auto px-4 py-14">
                    <div className="grid grid-cols-1 md:grid-cols-12 gap-10">
                        <div className="md:col-span-4">
                            <div className="text-2xl" style={{"fontFamily": "var(--font-display)", "color": "white"}}>SwissEscape</div>
                            <p className="mt-4 text-sm leading-relaxed" style={{"color": "rgba(255,255,255,0.72)"}}>
                                Switzerland's premium travel marketplace. Discover curated local experiences, scenic journeys, and luxury stays.
                            </p>
                            <div className="mt-6 flex items-center gap-3">
                                <a href="#" className="h-10 w-10 rounded-xl border flex items-center justify-center hover:bg-white/5 transition-colors" style={{"borderColor": "rgba(255,255,255,0.14)", "color": "rgba(255,255,255,0.85)"}} aria-label="Instagram">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <rect x="3" y="3" width="18" height="18" rx="5" stroke="currentColor" strokeWidth="2" />
                                        <circle cx="12" cy="12" r="4" stroke="currentColor" strokeWidth="2" />
                                        <circle cx="17.5" cy="6.5" r="1" fill="currentColor" />
                                    </svg>
                                </a>
                                <a href="#" className="h-10 w-10 rounded-xl border flex items-center justify-center hover:bg-white/5 transition-colors" style={{"borderColor": "rgba(255,255,255,0.14)", "color": "rgba(255,255,255,0.85)"}} aria-label="Facebook">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M14 8h3V5h-3c-2.2 0-4 1.8-4 4v3H7v3h3v7h3v-7h3l1-3h-4V9c0-.6.4-1 1-1Z" fill="currentColor" />
                                    </svg>
                                </a>
                                <a href="#" className="h-10 w-10 rounded-xl border flex items-center justify-center hover:bg-white/5 transition-colors" style={{"borderColor": "rgba(255,255,255,0.14)", "color": "rgba(255,255,255,0.85)"}} aria-label="Twitter">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M20 7.5c-.6.3-1.2.4-1.9.5.7-.4 1.2-1 1.4-1.8-.6.4-1.3.7-2.1.8-.6-.6-1.4-1-2.3-1-1.8 0-3.2 1.5-3.2 3.3 0 .3 0 .6.1.8-2.7-.1-5.1-1.5-6.7-3.6-.3.6-.4 1.2-.4 1.9 0 1.1.5 2.1 1.4 2.7-.5 0-1-.2-1.5-.4v.1c0 1.6 1.1 2.9 2.6 3.2-.3.1-.6.1-.9.1-.2 0-.4 0-.6-.1.4 1.4 1.7 2.4 3.2 2.4-1.2 1-2.7 1.6-4.3 1.6H4c1.6 1 3.5 1.6 5.6 1.6 6.7 0 10.4-5.7 10.4-10.6v-.5c.7-.5 1.2-1.1 1.7-1.8Z" fill="currentColor" />
                                    </svg>
                                </a>
                            </div>
                        </div>

                        <div className="md:col-span-2">
                            <div className="text-xs uppercase tracking-[0.16em]" style={{"color": "rgba(255,255,255,0.7)"}}>Explore</div>
                            <div className="mt-4 flex flex-col gap-2">
                                <Link to="/destinations" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Destinations</Link>
                                <Link to="/experiences" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Experiences</Link>
                                <Link to="/stays" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Stays</Link>
                                <Link to="/dashboard" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Dashboard</Link>
                                <Link to="/guides" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Travel Guides</Link>
                            </div>
                        </div>

                        <div className="md:col-span-2">
                            <div className="text-xs uppercase tracking-[0.16em]" style={{"color": "rgba(255,255,255,0.7)"}}>Company</div>
                            <div className="mt-4 flex flex-col gap-2">
                                <Link to="/about" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>About Us</Link>
                                <Link to="/host" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Become a Host</Link>
                                <Link to="/careers" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Careers</Link>
                                <Link to="/press" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Press</Link>
                                <Link to="/contact" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Contact</Link>
                            </div>
                        </div>

                        <div className="md:col-span-4">
                            <div className="text-xs uppercase tracking-[0.16em]" style={{"color": "rgba(255,255,255,0.7)"}}>Newsletter</div>
                            <p className="mt-4 text-sm leading-relaxed" style={{"color": "rgba(255,255,255,0.72)"}}>
                                Get travel inspiration and exclusive deals delivered to your inbox.
                            </p>
                            <div className="mt-5 flex gap-2">
                                <input
                                    className="flex-1 h-11 rounded-2xl px-4 text-sm outline-none"
                                    style={{"backgroundColor": "rgba(255,255,255,0.08)", "border": "1px solid rgba(255,255,255,0.14)", "color": "rgba(255,255,255,0.9)"}}
                                    placeholder="Email address"
                                />
                                <button
                                    className="h-11 w-11 rounded-2xl inline-flex items-center justify-center border hover:opacity-95 transition-opacity"
                                    style={{"backgroundColor": "var(--color-gold)", "borderColor": "var(--color-gold)", "color": "rgba(7,20,39,0.95)"}}
                                    aria-label="Submit"
                                >
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M22 2L11 13" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                        <path d="M22 2L15 22l-4-9-9-4 20-7Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div className="mt-12 pt-6 border-t flex flex-col md:flex-row md:items-center md:justify-between gap-3 text-xs" style={{"borderColor": "rgba(255,255,255,0.12)", "color": "rgba(255,255,255,0.65)"}}>
                        <div>© 2026 SwissEscape. All rights reserved.</div>
                        <div className="flex gap-4">
                            <a href="#" className="hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.65)"}}>Privacy</a>
                            <a href="#" className="hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.65)"}}>Terms</a>
                            <a href="#" className="hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.65)"}}>Cookies</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    );
}
