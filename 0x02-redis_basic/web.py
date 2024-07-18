#!/usr/bin/env python3
"""Redis Module"""

from functools import wraps
import redis
import requests
from typing import Callable

redis_ = redis.Redis()


def count_requests(method: Callable) -> Callable:
    """Decorator to count the number of
    requests made to a URL."""
    @wraps(method)
    def wrapper(url: str) -> str:
        """Wrapper function to increment the
        request count and cache the response."""
        redis_.incr(f"count:{url}")
        cached_html = redis_.get(f"cached:{url}")
        if cached_html:
            return cached_html.decode('utf-8')
        html = method(url)
        redis_.setex(f"cached:{url}", 10, html)
        return html

    return wrapper


@count_requests
def get_page(url: str) -> str:
    """Fetches the HTML content of a given URL."""
    req = requests.get(url)
    return req.text
